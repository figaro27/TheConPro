/**
 * Created by tbbates on 7/14/14.
 */
'use strict';
module.exports = function () {
    var Q = require('q'),
        base = require('./base')(),
        objectType = 'person';

    function SearchMethod() {
        return {
            byId: {where: {id: 'need to supply the id'}},
            byPersonId: {where: {personid: 'need to supply the personid'}}
        };
    }

    function create(app, req) {

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
            base.BuildSaveArray(itemsToSave, sourceData, build(app, model, isNew), model);

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
        }
        catch (e) {
            return deferred.reject({message : e, code : 400 });
        }
        return deferred.promise;
    }

    function build(app, source, isNew) {
        var deferred = Q.defer(),
            errors = [],
            personModel = require('./../models/' + objectType)(app.db).Model();

        if (!source) {
            return deferred.reject({message : 'source ' + objectType + ' missing', code : 420 });
        }

        if (isNew && !source.id) {
            return deferred.reject({message : 'source ' + objectType + ' id missing', code : 420 });
        }


        try {
            var criteria = new SearchMethod().byId;
            criteria.where.id = source.id;
            base.GetEntity(personModel, criteria, true)
                .then(function (person) {

                    if (source.firstname) {
                        person.firstname = source.firstname;
                    }
                    else {
                        person.firstname = '';
                    }
                    if (source.lastname) {
                        person.lastname = source.lastname;
                    }
                    else{
                        person.lastname = '';
                    }
                    if (source.company) {
                        person.company = source.company;
                    }
                    else {
                        person.company = '';
                    }

                    base.VerifyDefaults(source, person, errors, isNew);

                    if (errors.length === 0) {
                        return deferred.resolve(person);
                    } else {
                        return deferred.reject({message : JSON.stringify(errors.join(', ')), code : 500 });
                    }
                })
                .fail(function (error) {
                    return deferred.reject(error);
                });

        }
        catch (e) {
            return deferred.reject({message : e, code : 500 });
        }

        return deferred.promise;
    }

    function populate(source, model) {

        if (source.id) {
            model.id = source.id;
        }

        if (source.firstname) {
            model.firstname = source.firstname;
        }
        else{
            model.firstname = '';
        }

        if (source.lastname) {
            model.lastname = source.lastname;
        }
        else{
            model.lastname ='';
        }

        if (source.company) {
            model.company = source.company;
        }
        else{
            model.company = '';
        }

    }

    function search(app, req) {
        var deferred = Q.defer(),
            body = req.body;

        try {

            var criteria;
            if (!(body.criteria instanceof Object)) {
                criteria = JSON.parse(body.criteria);
            }
            else {
                criteria = body.criteria;
            }

            var ids = base.GetSearchCriteria(criteria, 'id');
            var objectModel = require('./../models/' + objectType)(app.db).Model();

            var modelCriteria = {};
            modelCriteria.where = {};
            if (ids.id && ids.id.length > 0) {
                modelCriteria.where.id = ids.id;
            }

            base.GetEntities(objectModel, modelCriteria)
                .then(function (searchresults) {
                    return deferred.resolve(searchresults);
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

    return {
        Build: build,
        Populate: populate,
        Create: create,
        Update: update,
        Search: search
    };
};