/**
 * Created by tbbates on 7/22/14.
 */
'use strict';
module.exports = function () {
    var Q = require('q'),
        base = require('./base')(),
        uuid = require('node-uuid'),
        objectType = 'team';

    _.mixin({
        'findByValues': function(collection, property, values) {
            return _.filter(collection, function(item) {
                return _.contains(values, item[property]);
            });
        }
    });

    function SearchMethod() {
        return {
            byId: {where: {id: 'need to supply the id'}},
            byStatus: {where: {status: 'need to supply the status'}}
        };
    }

    function create(app, req) {
        var deferred = Q.defer(),
            changePerson = req.user.person,
            teamSystem = require('./teamsystem')();
        try {
            save(app, req.body, changePerson, true)
                .then(function (data) {
                    teamSystem.ShareNewTeam(app, req, data)
                        .then(function(){
                            deferred.resolve(data);
                        }, function(error){
                            deferred.reject(error);
                        });

                }, function (error) {
                    deferred.reject(error);
                });
        }

        catch (e) {
            return deferred.reject({message : e, code : 400 });
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
            return deferred.reject({message : e, code : 400 });
        }
        return deferred.promise;
    }

    function remove(app, req) {
        var deferred = Q.defer(),
            err = new Error();

        if (!req.params) {
            err = new Error('req missing parameters');
            err.code = 420;
            throw  err;
        }

        if (!req.params.id) {
            err = new Error('req missing parameters');
            err.code = 420;
            throw  err;
        }

        try {
            var objectModel = require('./../models/' + objectType)(app.db).Model();

            var criteria = new SearchMethod().byId;
            criteria.where.id = req.params.id;

            base.RemoveEntity(objectModel, criteria)
                .then(function () {
                    return deferred.resolve(req.params.id);
                },
                function (error) {
                    return deferred.reject(error);
                });
        }
        catch (e) {
            return deferred.reject({message : e, code : 400 });
        }
        return deferred.promise;
    }

    function populate(source, model, isNew) {

        if (isNew) {
            model.id = uuid.v4();
        }
        else {
            model.id = source.id;
        }

        if (source.name) {
            model.name = source.name;
        }

    }

    function save(app, body, changePerson, isNew) {
        var deferred = Q.defer(),
            model = {},
            actionDate = new Date();
        try {
            var source = body; //JSON.parse(body);

            base.PopulateDefaults(source, model, actionDate, changePerson, isNew);
            populate(source, model, isNew);


            var itemsToSave = [];
            var sourceData = [];
            base.BuildSaveArray(itemsToSave, sourceData, build(app, model, isNew, changePerson), model);

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
                                        deferred.reject({message : error, code : 500 });
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
            //

        }
        catch (e) {
            return deferred.reject({message : e, code : 400 });
        }
        return deferred.promise;
    }

    function search(app, req) {
        var deferred = Q.defer(),
            body = req.body;

        try {

            var baseTeams = [];
            baseTeams.push(membership(app, req));
            baseTeams.push(ownership(app,req));

            Q.all(baseTeams)
                .then(function(searchResult){

                    var result = [];


                    _.each(searchResult, function(innerResult){
                        _.each(innerResult, function(team){
                            if(_.where(result,{'id': team.id}).length === 0){
                                result.push(team);
                            }

                        });
                    });



                    var criteria;
                    if (!(body.criteria instanceof Object)) {
                        criteria = JSON.parse(body.criteria);
                    }
                    else {
                        criteria = body.criteria;
                    }

                    var ids = base.GetSearchCriteria(criteria, 'id');
                    var names = base.GetSearchCriteria(criteria, 'name');
                    var statuses = base.GetSearchCriteria(criteria, 'status');


                    var modelCriteria = {};
                    modelCriteria.where = {};
                    if (ids.id && ids.id.length > 0) {
                        result = _.findByValues(result, 'id', ids.id);
                    }

                    if (names.name && names.name.length > 0) {
                        result = _.findByValues(result, 'name', names.name);
                    }

                    if (statuses.status && statuses.status.length > 0) {
                        modelCriteria.where.status = statuses.status;
                        result = _.findByValues(result, 'status', statuses.status);
                    }

                    return deferred.resolve(result);
                })
                .fail(function (error) {
                    return deferred.reject(error);
                });



        }
        catch (e) {
            return deferred.reject({message : e, code : 400 });
        }
        return deferred.promise;
    }

    function ownership(app, req) {
        var person = req.user.person;
        var model = require('./../models/' + objectType)(app.db).Model();
        var sql = 'select * from team where addedby = \'{0}\''.format(person);
        return base.GetEntityModels(app, model, sql);
    }

    function membership(app, req) {
        var person = req.user.person;
        var model = require('./../models/' + objectType)(app.db).Model();
        var sql = 'select a.* from team a inner join teamdetail b on a.id=b.teamid  where b.personid  = \'{0}\''.format(person);
        return base.GetEntityModels(app, model, sql);
    }

    function build(app, source, isNew, person) {
        var deferred = Q.defer(),
            errors = [],
            model = require('./../models/' + objectType)(app.db).Model();


        if (!source) {
            return deferred.reject({message : 'source ' + objectType + ' missing', code : 420 });
        }

        if (isNew && !source.id) {
            return deferred.reject({message : 'source ' + objectType + ' id missing', code : 420 });
        }

        try {

            var criteria = new SearchMethod().byId;
            criteria.where.id = source.id;

            if(!isNew){
                //
                var sql = 'select distinct id from team where addedby = \'{0}\' and id =\'{1}\''.format(person, source.id);
                base.GetEntityModels(app, model, sql)
                    .then(function(teams){
                        var buildResult = teams[0];

                        if (!source.name && isNew) {
                            errors.push('missing name');
                        } else if (source.name && source.name.length === 0) {
                            errors.push('missing name');
                        } else {
                            buildResult.name = source.name;
                            buildResult.hasChanges = true;
                        }

                        base.VerifyDefaults(source, buildResult, errors, isNew);

                        if (errors.length === 0) {
                            return deferred.resolve(buildResult);
                        } else {
                            return deferred.reject({message : JSON.stringify(errors.join(', ')), code : 500 });
                        }
                    })
                    .fail(function (error) {
                        return deferred.reject(error);
                    });
                //
            }
            else{
                base.GetEntity(model, criteria, true)
                    .then(function (buildResult) {

                        if (!source.name && isNew) {
                            errors.push('missing name');
                        } else if (source.name && source.name.length === 0) {
                            errors.push('missing name');
                        } else {
                            buildResult.name = source.name;
                            buildResult.hasChanges = true;
                        }


                        base.VerifyDefaults(source, buildResult, errors, isNew);

                        if (errors.length === 0) {
                            return deferred.resolve(buildResult);
                        } else {
                            return deferred.reject({message : JSON.stringify(errors.join(', ')), code : 500 });
                        }
                    })
                    .fail(function (error) {
                        return deferred.reject(error);
                    });

            }


        }
        catch (e) {
            return deferred.reject({message : e, code : 500 });
        }

        return deferred.promise;
    }

    return {
        Build: build,
        Populate: populate,
        Create: create,
        Update: update,
        Remove: remove,
        Search: search,
        Membership: membership,
        Ownership: ownership
    };
};