/**
 * Created by tbbates on 5/12/15.
 */
'use strict';
var Q = require('q'),
    validUrl = require('valid-url'),
    base = require('./base')(),
    objectType = 'contracttemplate',
    teamDelegate = require('./team'),
    contractAccess = teamDelegate.Permission.ReadContract | teamDelegate.Permissions.EditContract,
    fullAccess =
        teamDelegate.Permissions.ReadSystem |
        teamDelegate.Permissions.EditSystem |
        teamDelegate.Permissions.ReadPerson |
        teamDelegate.Permissions.EditPerson |
        teamDelegate.Permissions.ReadFinancial |
        teamDelegate.Permissions.EditFinancial |
        teamDelegate.Permissions.ReadContract |
        teamDelegate.Permissions.EditContract;

var contracttemplate = function contracttemplate() {
};

_.mixin({
    'findByValues': function (collection, property, values) {
        return _.filter(collection, function (item) {
            return _.contains(values, item[property]);
        });
    }
});

function SearchMethod() {
    return {
        byId: {where: {id: 'need to supply the id'}},
        byLeadId: {where: {leadid: 'need to supply the leadid'}},
        personLeads: {where: {leadid: 'need to supply person user id', status: [1]}},
        byProjectStatus: {where: {projectstatus: 'need to supply the projetstatus'}}
    };
}

function populate(source, model) {
    if (source.id) {
        model.id = source.id;
    }

    if (source.name) {
        model.name = source.name;
    }

    if (source.type) {
        model.type = source.type;
    }

    model.termid = source.termid;
    model.headerid = source.headerid;
    model.footerid = source.footerid;

    if(source.layoutid){
        model.layoutid = source.layoutid;
    }
}

function build(app, source, isNew) {
    var deferred = Q.defer();
    var errors = [],
        projectModel = require('./../models/' + objectType)(app.db).Model();


    if (!source) {
        return deferred.reject({message: 'source ' + objectType + ' missing', code: 420});
    }

    if (isNew && !source.id) {
        return deferred.reject({message: 'source ' + objectType + ' id missing', code: 420});
    }

    try {
        var criteria = new SearchMethod().byId;
        criteria.where.id = source.id;
        base.GetEntity(projectModel, criteria, true)
            .then(function (contracttemplate) {

                if (!source.name && isNew) {
                    errors.push('missing name');
                } else {
                    contracttemplate.name = source.name;
                }

                if (!source.type && isNew) {
                    errors.push('missing type');
                } else {
                    contracttemplate.type = source.type;
                }

                if (source.termid)      contracttemplate.termid = source.termid;
                if (source.headerid)    contracttemplate.headerid = source.headerid;
                if (source.footerid)    contracttemplate.footerid = source.footerid;


                if (!source.layoutid && isNew) {
                    errors.push('missing layout id');
                } else {
                    contracttemplate.layoutid = source.layoutid;
                }

                base.VerifyDefaults(source, contracttemplate, errors, isNew);

                if (errors.length === 0) {
                    return deferred.resolve(contracttemplate);
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

function validateFileFromID(id) {
    if (id == null)
        return 0;

    var fs = require("fs");
    var path = "upload/" + id + ".png";

    var stat = fs.lstatSync(path);

    if (stat.isFile()) {
        return stat['size'];
    }

    return 0;
}

function readFileFromID(id) {
    var deferred = Q.defer();
    var fs = require("fs");

    fs.readFile("upload/" + id + ".txt", "utf8", function(err, data) {
        if (err) {
            deferred.reject(err);
        }
        else {
            deferred.resolve(data);
        }
    });

    return deferred.promise;
}

function writeToFile(content, type, _id) {
    var deferred = Q.defer();

    var base64Data = "";
    var path = "upload/";
    var fs = require("fs");

    var uuid = require('node-uuid');
    var id = (typeof(_id) == "undefined" || _id == null) ? uuid.v1() : _id;

    console.log(content + "    " + type + id + "\r\n");

    if (type == "img") {
        if (validUrl.isHttpUri(content)) {
            deferred.resolve(id);
        }
        else {
            if (content.indexOf('data:image/png;base64,') == -100) {
                deferred.resolve(id);
            }
            else {
                base64Data = content.replace(/^data:image\/png;base64,/, "");

                fs.writeFile("upload/" + id + ".png", base64Data, 'base64', function(err) {
                    if (err == null) {
                        deferred.resolve(id);
                    }
                    else {
                        deferred.reject();
                    }
                });
            }
        }
    }
    else if (type == "txt") {
        fs.writeFile("upload/" + id + ".txt", content, function(err) {
            if (err == null) {
                deferred.resolve(id);
            }
            else {
                deferred.reject();
            }
        });
    }



    return deferred.promise;
}


function save(app, body, changePerson, isNew) {
    var deferred = Q.defer(),
        model = {},
        actionDate = new Date();

    try {
        var source = body;

        base.PopulateDefaults(source, model, actionDate, changePerson, isNew);



        Q.all ([
            writeToFile(source.term.data, "txt", source.termid),
            writeToFile(source.header.data, "img", source.headerid),
            writeToFile(source.footer.data, "img", source.footerid),
        ]).then(function(ret) {
            //deferred.resolve(ret);
            source.termid = ret[0];
            source.headerid = ret[1];
            source.footerid = ret[2];

            populate(source, model, isNew);

            var itemsToSave = [];
            var sourceData = [];

            console.log("Saving....\r\n");

            base.BuildSaveArray(itemsToSave, sourceData, build(app, model, isNew), model);

            //if this is an update, if the current user is not the user that created the template then return
            //an error letting the user know that they are not the owner.
            if(isNew === false){
                if(changePerson !== source.addedby){
                    return deferred.reject('only the user that created the contract template is able to make changes');
                }
            }

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

                                console.log("Almost....\r\n");

                                t.commit()
                                    .error(function (error) {
                                        deferred.reject({message: error, code: 500});
                                    });
                                t.done(function () {
                                    deferred.resolve(newmodel[0]);
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

        }).fail(function (error) {
            deferred.reject(error);
        });
    }
    catch (e) {
        deferred.reject({message: e, code: 400});
    }

    return deferred.promise;
}

function generate(app, req) {
    console.log("Generating...\r\n");

    var deferred = Q.defer(),
        changePerson = req.user.person; // person making the changes
    try {
        save(app, req.body, changePerson, true)
            .then(function (data) {
                deferred.resolve(data);
            }, function (error) {
                deferred.reject(error);
            });
    }

    catch (e) {
        return deferred.reject({message: e, code: 400});
    }
    return deferred.promise;
}

function update(app, req) {

    var deferred = Q.defer(),
        changePerson = req.user.person; // person making the changes
    try {
        save(app, req.body, changePerson, false)
            .then(function (data) {
                deferred.resolve(data);
            }, function (error) {
                deferred.reject(error);
            });
    }

    catch (e) {
        return deferred.reject({message: e, code: 400});
    }
    return deferred.promise;
}

function innerSearch(app, req) {
    var deferred = Q.defer(),
        body = req.body,
        criteria,
        baseTeams = [],
        hints = {
            searchType: 'use',
            populate: false
        };
    try {

        if (!(body.criteria instanceof Object)) {
            criteria = JSON.parse(body.criteria);
        }
        else {
            criteria = body.criteria;
        }

        if (body.hints) {
            if (!(body.hints instanceof Object)) {
                hints = JSON.parse(body.hints);
            }
            else {
                hints = body.hints;
            }
        }

        if (hints.status) {
            criteria.push({status: hints.status});
        }

        if (hints.searchType === 'use' || hints.searchType === 'maintain') {
            if (_.contains(req.user.roles, 'user') === true) {
                // get contract templates that are owned by
                baseTeams.push(base.Ownership(app, req.user.person, objectType));
            }
            if (
                _.contains(req.user.roles, 'subscriber') === true ||
                _.contains(req.user.roles, 'concreteprotector') === true ||
                _.contains(req.user.roles, 'administrator') === true
            ) {
                baseTeams.push(base.Ownership(app, req.user.person, objectType));
                baseTeams.push(base.TeamMembership(app, req.user.person, objectType, contractAccess));
            }
        }



        // we are getting the contract templates so that we can check at the end to make sure the
        // results are for contract templates that the user has access to use
        Q.all(baseTeams)
            .then(function (contractTemplateResults) {
                contractTemplateResults = base.FixSqlResult((contractTemplateResults));
                var contractTemplates = [];

                //get the unique searchresults
                //get the unique searchresults
                _.each(contractTemplateResults, function (innerResult) {
                    _.each(innerResult, function (contractTemplate) {
                        if (_.where(contractTemplates, {'id': contractTemplate.id}).length === 0) {
                            contractTemplates.push(contractTemplate);

                        }
                    });
                });

                var ids = base.GetSearchCriteria(criteria, 'id');
                var fids = base.GetSearchCriteria(criteria, 'fid');
                var statuses = base.GetSearchCriteria(criteria, 'status');

                var modelCriteria = {};
                modelCriteria.where = {};
                var final = false;
                if (final === false && ids.id && ids.id.length > 0) {
                    contractTemplates = _.findByValues(contractTemplates, 'id', ids.id);
                    final = true;
                }

                if (final === false && fids.id && fids.id.length > 0) {
                    contractTemplates = _.findByValues(contractTemplates, 'fid', fids.fid);
                    final = true;
                }
                if (final === false && statuses.status && statuses.status.length > 0) {
                    contractTemplates = _.findByValues(contractTemplates, 'status', statuses.status);
                    final = true;
                }

                if (!hints.populate) {
                    if (contractTemplates.length == 1) {
                        var template = contractTemplates[0];

                        template.headerImgSize = validateFileFromID(template.headerid);
                        template.footerImgSize = validateFileFromID(template.footerid);

                        Q.all(readFileFromID(template.termid)).then(function(data) {
                            template.term = data;

                            deferred.resolve(contractTemplates);
                        }).fail(function(err) {
                            deferred.resolve(contractTemplates);
                        });
                    }
                    else {
                        deferred.resolve(contractTemplates);
                    }
                }





            })
            .fail(function (error) {
                deferred.reject(error);
            });
    }
    catch (e) {
        deferred.reject({message: e, code: 400});
    }
    return deferred.promise;
}

function search(app, req) {
    var deferred = Q.defer();
    try {
        innerSearch(app, req)
            .then(function (data) {
                // Load template page

                // Get a list of the add users to see if they have permission to view contract info
                // innerSearch already make sure that the user has access to view the contract template
                var results = [],
                    suspect = [],
                    person = req.user.person;

                // if the adduser is the person requesting the data, then add it to the results
                _.each(data, function (contracttemplate) {
                    contracttemplate.permission = 0;
                    if (contracttemplate.addedby === person) {
                        contracttemplate.permission = fullAccess;
                        results.push(contracttemplate);
                    } else {
                        suspect.push(contracttemplate);
                    }
                });

                if (suspect.length === 0) {
                    return deferred.resolve(results);
                }

                var users = [];

                _.each(suspect, function (contractTemplate) {
                    users.push(teamDelegate.Membership(app, person, contractTemplate.addedby, contractAccess));
                });

                Q.all(users)
                    .then(function (membership) {
                        membership = base.FixSqlResult(membership);
                        _.each(suspect, function (project, i) {
                            project.permission = 0;
                            if (membership[i]) {
                                var thisMembership = membership[i];
                                project.permission = thisMembership.permission;
                            }
                            results.push(project);
                        });
                    }, function (failure) {
                        return deferred.reject(failure);
                    });


                return deferred.resolve(data);
            }, function (error) {
                return deferred.reject(error);
            });
    }
    catch (e) {
        return deferred.reject({message: e, code: 400});
    }
    return deferred.promise;
}

contracttemplate.prototype.Populate = populate;
contracttemplate.prototype.Build = build;
contracttemplate.prototype.Generate = generate;
contracttemplate.prototype.Update = update;
contracttemplate.prototype.Search = search;
contracttemplate.instance = null;

if (contracttemplate.callee !== contracttemplate.getInstance) {
    throw new Error('This object cannot be instantiated');
}

contracttemplate.getInstance = function () {
    if (this.instance === null) {
        this.instance = new contracttemplate();
    }
    return this.instance;
};
module.exports = contracttemplate.getInstance();