/**
 * Created by tbbates on 7/18/14.
 */
'use strict';
module.exports = function () {
    var jwt = require('jsonwebtoken'),
        crypto = require('crypto'),
        base = require('./base')(),
        bcrypt = require('bcrypt-nodejs'),
        Q = require('q'),
        uuid = require('node-uuid'),
        moment = require('moment'),
        objectType = 'account',
        p = require('password');

    function SearchMethod() {
        return {
            byId: {where: {id: 'need to supply the id'}},
            byAccountId: {where: {accountid: 'need to supply the accountid'}},
            byUsername: {where: {username: 'need to supply the username'}},
            activeUsername: {where: {username: 'need to supply the username', status: status.active}}
        };
    }

    var status = {
        inactive: '0',
        active: '1',
        noperson: '2'
    };

    function doesPasswordMatch(account, password) {
        var result = {
                success: false,
                profile: {
                    account: '',
                    person: ''
                },
                message: 'Wrong password'
            },
            deferred = Q.defer();

        if (account) {
            if (account.passwordtype === '1') {
                if (account.password === password) {
                    result.success = true;
                    result.profile.account = account.id;
                    result.profile.person = account.id;
                    result.message = '';
                }
                return deferred.resolve(result);

            }
            if (account.passwordtype === '0') {
                bcrypt.compare(password, account.password, function (err, res) {
                    if (res === true) {
                        result.success = true;
                        result.profile.account = account.id;
                        result.profile.person = account.id;
                        result.message = '';
                    }
                    return deferred.resolve(result);
                });
            }
        }

        return deferred.promise;
    }

    function login(app, body) {
        var deferred = Q.defer();

        if (!body.username || body.username.length === 0) {
            return deferred.reject({message: 'missing username', code: 420});
        }
        if (!body.password || body.password.length === 0) {
            return deferred.reject({message: 'missing password', code: 420});
        }

        try {
            body.username = body.username.toLowerCase();
            var account = require('./../models/account')(app.db).Model(),
                criteria = new SearchMethod().activeUsername;

            criteria.where.username = body.username.toLowerCase();
            base.GetEntity(account, criteria, false)
                .then(
                function (account) {
                    if (!account) {
                        return deferred.reject({message: 'Nobody here by that name', code: 401});
                    }

                    if (account) {
                        doesPasswordMatch(account, body.password)
                            .then(function (accountInfo) {
                                if (accountInfo.success === false) {
                                    var err = new Error('wrong password');
                                    err.code = 401;
                                    throw  err;
                                }

                                var queries = [];

                                //
                                var accountrole = require('./../models/accountrole')(app.db).Model(),


                                    accountrolecriteria = new SearchMethod().byAccountId;
                                accountrolecriteria.where.accountid = account.id;

                                var person = require('./../models/person')(app.db).Model(),
                                    personcriteria = new SearchMethod().byId;
                                personcriteria.where.id = account.id;


                                queries.push(base.GetEntities(accountrole, accountrolecriteria));
                                queries.push(base.GetEntity(person, personcriteria, false));

                                Q.all(queries)
                                    .then(function (data) {
                                        var thisPerson = data[1];

                                        var profile = accountInfo.profile;
                                        profile.roles = _.pluck(data[0], 'role');
                                        profile.firstname = thisPerson.firstname;
                                        profile.lastname = thisPerson.lastname;
                                        profile.username = account.username;
                                        profile.id = account.id;


                                        generateToken(app, profile)
                                            .then(function (success) {
                                                deferred.resolve(success);
                                            })
                                            .fail(function (error) {
                                                deferred.reject(error);
                                            });
                                    })
                                    .fail(function (error) {
                                        return deferred.reject(error);
                                    });
                            })
                            .fail(function (error) {
                                return deferred.reject(error);
                            });

                        //
                    }


                },
                function (error) {
                    return deferred.reject(error);
                });
        }
        catch (e) {
            return deferred.reject({message: e, code: 500});
        }
        return deferred.promise;
    }

    /**
     * This method will return an account when searching by email.
     * It will return a new account if the email address is not found,
     * if a new account is created the account status is set to noperson
     * @param app
     * @param body = body.username
     * @returns {*}
     */
    function resolve(app, body) {
        var deferred = Q.defer();

        try {
            if (!body.username || body.username.length === 0) {
                return deferred.reject({message: 'username', code: 420});
            }

            var model = require('./../models/account')(app.db).Model(),
                username = body.username.toLowerCase(),
                sql = 'select * from account where username = \'{0}\''.format(username),
                actionDate = new Date();

            base.GetEntityModels(app, model, sql)
                .then(function (data) {
                    // we found an account
                    if (data.length > 0) {
                        var result = JSON.parse(JSON.stringify(data[0]));
                        return deferred.resolve(result);
                    }
                    //we did not find an account
                    else {
                        var account = {};
                        account.id = uuid.v4();
                        base.PopulateDefaults(account, model, actionDate, account.id, true);
                        account.status = status.noperson;
                        account.username = username;
                        account.password = account.id;

                        populate(account, model, true);
                        model.id = account.id;
                        model.status = account.status;
                        model.passwordtype = 0;

                        var accountroledelegate = require('./accountrole')();
                        var accountrolemodel = require('./../models/accountrole')(app.db).Model();

                        var accountrole = {};
                        accountrole.accountid = account.id;
                        accountrole.role = 'user';

                        base.PopulateDefaults(accountrole, accountrolemodel, actionDate, account.id, true);
                        accountroledelegate.Populate(accountrole, accountrolemodel, true);


                        var itemsToSave = [];
                        var sourceData = [];
                        base.BuildSaveArray(itemsToSave, sourceData, build(app, model, true), model);
                        base.BuildSaveArray(itemsToSave, sourceData, accountroledelegate.Build(app, accountrolemodel, true), accountrolemodel);
//`
                        Q.all(itemsToSave)
                            .then(function (data) {
                                app.db.Sequelize.transaction(function (t) {

                                    var finalbuild = [];
                                    for (var i = 0; i < data.length; i++) {
                                        finalbuild.push(base.SaveEntity(data[i], sourceData[i], t));
                                    }
                                    Q.all(finalbuild)
                                        .then(
                                        function (newmodel) {
                                            t.commit()
                                                .error(function (error) {
                                                    deferred.reject({message: error, code: 500});
                                                });
                                            t.done(function () {
                                                deferred.resolve(newmodel[0]);
                                                var result = JSON.parse(JSON.stringify(newmodel[0]));
                                                result.accountIsNew = true;
                                                return deferred.resolve(result);
                                            });
                                        },
                                        function (msg) {
                                            t.rollback();
                                            deferred.reject(msg);
                                        });
                                });
                            })
                            .fail(function (error) {
                                return deferred.reject(error);
                            });
                        //`
                    }
                })
                .fail(function (error) {
                    return deferred.reject(error);
                });
        }
        catch (e) {
            return deferred.reject({message: e, code: 500});
        }
        return deferred.promise;
    }

    /**
     * extenToken will extend the expiration time of the user's access token
     * @param app
     * @param req
     */
    function extendToken(app, req) {
        var deferred = Q.defer();

        try {

            if (req.token) {
                //Decrypt the user token from the request user
                var requestUser = decryptAes(app.config.jwtKey, req.token),
                    userObject = JSON.parse(requestUser);

                generateToken(app, userObject)
                    .then(function (success) {
                        deferred.resolve(success);
                    })
                    .fail(function (error) {
                        deferred.reject(error);
                    });
            }

        }
        catch (e) {
            return deferred.reject({message: e, code: 500});
        }
        return deferred.promise;
    }

    function encryptAes(password, input) {
        var cipher = crypto.createCipher('aes-256-cbc', password);
        var cryptedBuffers = [cipher.update(new Buffer(input))];
        cryptedBuffers.push(cipher.final());
        return Buffer.concat(cryptedBuffers);
    }

    function decryptAes(password, input) {
        var dcipher = crypto.createDecipher('aes-256-cbc', password);

        var dcryptedBuffers = [dcipher.update(new Buffer(input))];
        dcryptedBuffers.push(dcipher.final());
        return Buffer.concat(dcryptedBuffers).toString('utf8');
    }

    function generateToken(app, profile) {
        var deferred = Q.defer();
        try {

            var expireTime = moment.utc().minutes(app.config.tokenExpiresIn).toDate();
            profile.expires = expireTime;

            var jsonProfile = JSON.stringify(profile);

            // encrypt profile
            var encrypted = {token: encryptAes(app.config.jwtKey, jsonProfile)};

            // sign the token
            var token = jwt.sign(encrypted, app.config.jwtSecret, {expiresInMinutes: app.config.tokenExpiresIn});

            var result = JSON.stringify({
                token: token,
                expires: expireTime,
                roles: profile.roles,
                name: '{0} {1}'.format(profile.firstname, profile.lastname),
                id: profile.id
            });

            deferred.resolve(result);
        }
        catch (e) {
            return deferred.reject({message: e, code: 500});
        }
        return deferred.promise;
    }

    function register(app, body) {

        var deferred = Q.defer(),
            person = {},
            account = {},
            pid = uuid.v4(), // person id
            accountIsNew = true,
            actionDate = new Date(),
            persondelegate = require('./person')(app.db);

        try {
            resolve(app, body)
                .then(function (resolvedAccount) {
                    if (resolvedAccount.status === status.noperson) {
                        accountIsNew = resolvedAccount.accountIsNew;
                        pid = resolvedAccount.id;
                        account.status = status.active;
                        // now use the account that was returned from the resolve function to build an app
                        //
                        //
                        base.PopulateDefaults(body, person, actionDate, pid, true);
                        person.id = pid;
                        person.firstname = body.firstname;
                        person.lastname = body.lastname;


                        base.PopulateDefaults(body, account, actionDate, pid, accountIsNew);
                        account.username = body.username.toLowerCase();
                        account.password = body.password;
                        account.id = pid;
                        account.version = resolvedAccount.version;
                        account.passwordtype = 0;

                        var itemsToSave = [];
                        var sourceData = [];
                        base.BuildSaveArray(itemsToSave, sourceData, persondelegate.Build(app, person, true), person);
                        base.BuildSaveArray(itemsToSave, sourceData, build(app, account, accountIsNew), account);
                        Q.all(itemsToSave)
                            .then(function (data) {
                                app.db.Sequelize.transaction(function (t) {
                                    var finalbuild = [];
                                    for (var i = 0; i < data.length; i++) {
                                        finalbuild.push(base.SaveEntity(data[i], sourceData[i], t));
                                    }
                                    Q.all(finalbuild)
                                        .then(
                                        function () {
                                            t.commit()
                                                .error(function (error) {
                                                    deferred.reject({message: error, code: 500});
                                                });
                                            t.done(function () {
                                                login(app, body)
                                                    .then(function (login) {
                                                        return deferred.resolve(login);
                                                    })
                                                    .fail(function (error) {
                                                        return deferred.reject(error);
                                                    });
                                            });
                                        },
                                        function (msg) {
                                            t.rollback();
                                            deferred.reject(msg);
                                        });
                                });
                            })
                            .fail(function (error) {
                                return deferred.reject(error);
                            });
                        //
                    } else {
                        return deferred.reject({
                            message: 'duplicate key value violates unique constraint \"ix_account_username\"',
                            code: 500
                        });
                    }

                }, function (error) {
                    return deferred.reject(error);
                });
        }
        catch (e) {
            return deferred.reject({message: e, code: 500});
        }
        return deferred.promise;
    }

    function build(app, source, isNew, criteria) {
        var deferred = Q.defer(),
            errors = [],
            accountModel = require('./../models/' + objectType)(app.db).Model(),
            searchCriteria = new SearchMethod().byId;

        if (!source) {
            return deferred.reject({message: 'source ' + objectType + ' missing', code: 420});
        }

        if (isNew && !source.id) {
            return deferred.reject({message: 'source ' + objectType + ' id missing', code: 420});
        }

        if (!criteria) {
            searchCriteria = new SearchMethod().byId;
            searchCriteria.where.id = source.id;
        } else {
            searchCriteria = criteria;
        }

        try {
            base.GetEntity(accountModel, searchCriteria, true)
                .then(function (account) {
                    isNew = account.isNewRecord;

                    //username
                    if (!source.username && isNew) {
                        errors.push('missing username');
                    } else if (source.username && source.username.length === 0) {
                        errors.push('missing username');
                    } else {
                        account.username = source.username;
                        account.hasChanges = true;
                    }

                    //password
                    if (!source.password && isNew) {
                        errors.push('missing password');
                    } else if (source.password && source.password.length === 0) {
                        errors.push('missing password');
                    } else if (source.password && source.password.length <= 5) {
                        errors.push('password length needs to be longer than 5 characters');
                    } else if (source.password) {
                        var accountSalt = bcrypt.genSaltSync(10);
                        account.password = bcrypt.hashSync(source.password, accountSalt);
                        account.passwordtype = 0;
                        account.hasChanges = true;
                    }

                    if (!isNew) {

                        if (!source.version && account.version) {
                            source.version = account.version;
                        }
                    }

                    base.VerifyDefaults(source, account, errors, isNew);


                    if (errors.length === 0) {
                        return deferred.resolve(account);
                    } else {
                        return deferred.reject({message: JSON.stringify(errors.join(', ')), code: 500});
                    }
                })
                .fail(function (error) {
                    return deferred.reject(error);
                });

        }
        catch (e) {
            return deferred.reject({message: e, code: 500});
        }

        return deferred.promise;
    }

    function feedback(app, req) {
        var deferred = Q.defer(),
            emailer = require('../../../modules/emailer')(),
            accountResource = require('../resources/account')();

        if (!req.body || req.body.length === 0) {
            return deferred.reject({message: 'feedback missing', code: 420});
        }
        var body = req.body;
        if (!body.feedback || body.feedback.length === 0) {
            return deferred.reject({message: 'feedback missing', code: 420});
        }

        try {
            var accountModel = require('./../models/account')(app.db).Model(),
                personModel = require('./../models/person')(app.db).Model(),
                criteria = new SearchMethod().byId;

            criteria.where.id = req.user.person;

            var qs = [];
            qs.push(base.GetEntity(accountModel, criteria, false));
            qs.push(base.GetEntity(personModel, criteria, false));
            Q.all(qs)
                .then(function (results) {
                    var account = results[0],
                        person = results[1];
                    accountResource.Feedback(account.username, ('{0} {1}').format(person.firstname, person.lastname), body.feedback)
                        .then(function (feedback) {
                            var from = app.config.senderemail,
                                to = app.config.suggestionemail,
                                subject = 'Coatings Estimator Suggestion';
                            emailer.SendHtmlEmail(app, from, to, subject, feedback);
                            deferred.resolve('suggestion sent to ' + app.config.suggestionemail);
                        }, function (error) {
                            deferred.reject({message: error, code: 500});
                        });

                }, function (error) {
                    deferred.reject({message: error, code: 500});
                });
        }
        catch (e) {
            return deferred.reject({message: e, code: 500});
        }
        return deferred.promise;
    }

    function forgotpassword(app, body) {
        var deferred = Q.defer(),
            emailer = require('../../../modules/emailer')(),
            accountResource = require('../resources/account')();

        if (!body.username || body.username.length === 0) {
            return deferred.reject({message: 'username missing', code: 420});
        }

        try {
            body.username = body.username.toLowerCase();
            var accountModel = require('./../models/account')(app.db).Model(),
                criteria = new SearchMethod().activeUsername;
            criteria.where.username = body.username;

            base.GetEntity(accountModel, criteria, false)
                .then(function (account) {
                    if (!account) {
                        return deferred.reject({message: 'account not found', code: 404});
                    }

                    var newPassword = p(1) + p(1);

                    var actionDate = new Date();
                    account.password = newPassword;


                    base.PopulateDefaults(account, account, actionDate, account.id, false);
                    populate(account, account, false);


                    var itemsToSave = [];
                    var sourceData = [];
                    base.BuildSaveArray(itemsToSave, sourceData, build(app, account, false), account);

                    Q.all(itemsToSave)
                        .then(function (data) {
                            app.db.Sequelize.transaction(function (t) {

                                var finalbuild = [];
                                for (var i = 0; i < data.length; i++) {
                                    finalbuild.push(base.SaveEntity(data[i], sourceData[i], t));
                                }
                                Q.all(finalbuild)
                                    .then(
                                    function () {
                                        t.commit()
                                            .error(function (error) {
                                                deferred.reject({message: error, code: 500});
                                            });
                                        t.done(function () {

                                            accountResource.ForgotPassword(account.username, null, newPassword)
                                                .then(function (passwordbody) {
                                                    var from = app.config.senderemail,
                                                        to = account.username,
                                                        subject = 'Forgot Password';
                                                    emailer.SendHtmlEmail(app, from, to, subject, passwordbody);
                                                    deferred.resolve('forgot password email sent to ' + account.username);
                                                }, function (error) {
                                                    deferred.reject({message: error, code: 500});
                                                });


                                        });
                                    },
                                    function (msg) {
                                        t.rollback();
                                        deferred.reject(msg);
                                    });
                            });
                        })
                        .fail(function (error) {
                            return deferred.reject(error);
                        });


                }, function (error) {
                    return deferred.reject({message: error, code: error.code || 500});
                });
        }
        catch (e) {
            return deferred.reject({message: e, code: 500});
        }
        return deferred.promise;
    }

    function changepassword(app, req) {
        var deferred = Q.defer();

        if (!req.body.password || req.body.password.length === 0) {
            return deferred.reject({message: 'missing password', code: 420});
        }

        if (!req.body.newpassword || req.body.newpassword.length === 0) {
            return deferred.reject({message: 'new missing password', code: 420});
        }

        if (req.body.newpassword === req.body.password) {
            return deferred.reject({message: 'new password can not be the same as your old password', code: 420});
        }

        var requestUser = decryptAes(app.config.jwtKey, req.token),
            userObject = JSON.parse(requestUser);

        try {
            var account = require('./../models/account')(app.db).Model(),
                criteria = new SearchMethod().activeUsername;

            criteria.where.username = userObject.username.toLowerCase();
            base.GetEntity(account, criteria, false)
                .then(
                function (account) {
                    if (!account) {
                        return deferred.reject({message: 'Nobody here by that name', code: 401});
                    }

                    if (account) {
                        doesPasswordMatch(account, req.body.password)
                            .then(function (accountInfo) {
                                if (accountInfo.success === false) {
                                    return deferred.reject({message: 'wrong password', code: 401});
                                }


                                var changedAccount = account,
                                    actionDate = new Date();
                                changedAccount.password = req.body.newpassword;
                                changedAccount.passwordtype = 0;


                                base.PopulateDefaults(account, changedAccount, actionDate, req.user.person, false);
                                populate(account, changedAccount, false);


                                var itemsToSave = [];
                                var sourceData = [];
                                base.BuildSaveArray(itemsToSave, sourceData, build(app, changedAccount, false), account);
                                // start
                                Q.all(itemsToSave)
                                    .then(function (data) {
                                        app.db.Sequelize.transaction(function (t) {

                                            var finalbuild = [];
                                            for (var i = 0; i < data.length; i++) {
                                                finalbuild.push(base.SaveEntity(data[i], sourceData[i], t));
                                            }
                                            Q.all(finalbuild)
                                                .then(
                                                function () {
                                                    t.commit()
                                                        .error(function (error) {
                                                            deferred.reject({message: error, code: 500});
                                                        });
                                                    t.done(function () {

                                                        // start
                                                        var queries = [];

                                                        var accountrole = require('./../models/accountrole')(app.db).Model(),
                                                            accountrolecriteria = new SearchMethod().byAccountId;
                                                        accountrolecriteria.where.accountid = account.id;

                                                        var person = require('./../models/person')(app.db).Model(),
                                                            personcriteria = new SearchMethod().byId;
                                                        personcriteria.where.id = account.id;


                                                        queries.push(base.GetEntities(accountrole, accountrolecriteria));
                                                        queries.push(base.GetEntity(person, personcriteria, false));

                                                        Q.all(queries)
                                                            .then(function (data) {
                                                                var thisPerson = data[1];

                                                                var profile = accountInfo.profile;
                                                                profile.roles = _.pluck(data[0], 'role');
                                                                profile.firstname = thisPerson.firstname;
                                                                profile.lastname = thisPerson.lastname;
                                                                profile.username = account.username;
                                                                profile.id = account.id;


                                                                generateToken(app, profile)
                                                                    .then(function (success) {
                                                                        deferred.resolve(success);
                                                                    })
                                                                    .fail(function (error) {
                                                                        deferred.reject(error);
                                                                    });
                                                            })
                                                            .fail(function (error) {
                                                                return deferred.reject(error);
                                                            });
                                                        // stop

                                                        // deferred.resolve(newmodel[0]);
                                                    });
                                                },
                                                function (msg) {
                                                    t.rollback();
                                                    deferred.reject(msg);
                                                });
                                        });
                                    })
                                    .fail(function (error) {
                                        return deferred.reject(error);
                                    });
                                // stop


                            })
                            .fail(function (error) {
                                return deferred.reject(error);
                            });

                        //
                    }


                },
                function (error) {
                    return deferred.reject(error);
                });
        }
        catch (e) {
            return deferred.reject({message: e, code: 500});
        }
        return deferred.promise;
    }

    function populate(source, model) {

        if (source.username) {
            model.username = source.username;
        }

        if (source.password) {
            model.password = source.password;
        }

        if (source.passwordtype) {
            model.passwordtype = source.passwordtype;
        }

    }

    return {
        Login: login,
        ExtendToken: extendToken,
        Register: register,
        Build: build,
        Status: status,
        Resolve: resolve,
        ForgotPassword: forgotpassword,
        Feedback: feedback,
        ChangePassword: changepassword,
        Populate: populate
    };
};