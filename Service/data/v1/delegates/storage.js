/**
 * Created by tbbates on 7/14/14.
 */
'use strict';
module.exports = function () {
    var Q = require('q'),
        base = require('./base')(),
        objectType = 'storage',
        pkgcloud = require('pkgcloud'),
        stream = require('stream'),
        MemoryStream = require('memorystream');

    function SearchMethod() {
        return {
            byId: {where: {id: 'need to supply the id'}},
            byFid: {where: {fid: 'need to supply the fid'}},
            byFidType: {where: {fid: 'need to supply the fid', type: 'need to supply the type'}}
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

            if (model.data && model.data.length > 0) {

                uploadString(app, model.id, model.data)
                    .then(function (file) {
                        model.contenttype = file.contentType;
                        model.hash = file.etag;
                        model.size = file.size;

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

                    }, function (error) {
                        return deferred.reject(error);
                    });


            }
            else {

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
            }
        }
        catch (e) {
            return deferred.reject({message: e, code: 400});
        }
        return deferred.promise;
    }

    function build(app, source, isNew) {
        var deferred = Q.defer(),
            errors = [],
            personModel = require('./../models/' + objectType)(app.db).Model();

        if (!source) {
            return deferred.reject({message: 'source ' + objectType + ' missing', code: 420});
        }

        if (isNew && !source.id) {
            return deferred.reject({message: 'source ' + objectType + ' id missing', code: 420});
        }


        try {
            var criteria = new SearchMethod().byId;
            criteria.where.id = source.id;
            base.GetEntity(personModel, criteria, true)
                .then(function (model) {

                    if (isNew) {
                        if (source.fid) {
                            model.fid = source.fid;
                        }

                        if (!source.filename) {
                            model.filename = '';
                        }
                        else {
                            model.filename = source.filename;
                        }


                        if (!source.contenttype) {
                            model.contenttype = '';
                        }
                        else {
                            model.contenttype = source.contenttype;
                        }

                        if (!source.type) {
                            model.type = '';
                        }
                        else {
                            model.type = source.type;
                        }

                        if (!source.hash) {
                            model.hash = '';
                        }
                        else {
                            model.hash = source.hash;
                        }

                        if (!source.container) {
                            model.container = '';
                        }
                        else {
                            model.container = source.container;
                        }

                        if (!source.size) {
                            source.size = 0;
                        }
                        else {
                            model.size = source.size;
                        }

                    }

                    else {

                        if (source.filename) {
                            model.filename = source.filename;
                        }

                        if (source.contenttype) {
                            model.contenttype = source.contenttype;
                        }

                        if (source.type) {
                            model.type = source.type;
                        }

                        if (source.hash) {
                            model.hash = source.hash;
                        }

                        if (source.container) {
                            model.container = source.container;
                        }

                        if (source.data) {
                            model.data = source.data;
                        }

                        if (source.size) {
                            model.size = source.size;
                        }
                    }


                    base.VerifyDefaults(source, model, errors, isNew);

                    if (errors.length === 0) {
                        return deferred.resolve(model);
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

    function populate(source, model) {

        if (source.id) {
            model.id = source.id;
        }

        if (source.fid) {
            model.fid = source.fid;
        }

        if (source.filename) {
            model.filename = source.filename;
        }

        if (source.contenttype) {
            model.contenttype = source.contenttype;
        }

        if (source.type) {
            model.type = source.type;
        }

        if (source.hash) {
            model.hash = source.hash;
        }

        if (source.container) {
            model.container = source.container;
        }

        if (source.data) {
            model.data = source.data;
        }

        if (source.size) {
            model.size = source.size;
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
            var fids = base.GetSearchCriteria(criteria, 'fid');
            var objectModel = require('./../models/' + objectType)(app.db).Model();

            var modelCriteria = {};
            modelCriteria.where = {};
            if (ids.id && ids.id.length > 0) {
                modelCriteria.where.id = ids.id;
            }
            if (fids.fid && fids.fid.length > 0) {
                modelCriteria.where.fid = fids.fid;
            }

            if (fids.length === 0 && ids.length === 0){
                return deferred.resolve([]);
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
            return deferred.reject({message: e, code: 400});
        }
        return deferred.promise;
    }

    function uploadString(app, remoteFilename, data) {
        var deferred = Q.defer();
        try {

            var client = pkgcloud.storage.createClient({
                provider: app.config.storage.provider,
                username: app.config.storage.username,
                region: app.config.storage.region,
                apiKey: app.config.storage.apiKey
            });

            var source = new stream.Readable();
            source._read = function noop() {
            }; // redundant? see update below
            source.push(data);
            source.push(null);

            var dest = client.upload({
                container: app.config.storage.container,
                remote: remoteFilename
            });

            dest.on('error', function (error) {
                console.log('error :' + error);
            });

            dest.on('success', function (file) {
                deferred.resolve(file);
            });

            source.pipe(dest);


        }
        catch (e) {
            return deferred.reject({message: e, code: 500});
        }

        return deferred.promise;
    }

    function downloadString(app, req) {
        var deferred = Q.defer();

        if (!req.params) {
            return deferred.reject('req missing parameters');
        }

        if (!req.params.filename) {
            return deferred.reject('req missing parameters');
        }

        try {
//http://code.openhub.net/file?fid=B4Fw94XUlLcweWhSSLkvC1zuZqA&cid=FPFkt7bAv-w&s=&fp=554078&mp&projSelected=true#L0
            var client = pkgcloud.storage.createClient({
                provider: app.config.storage.provider,
                username: app.config.storage.username,
                region: app.config.storage.region,
                apiKey: app.config.storage.apiKey
            });

            var options = {
                container: app.config.storage.container,
                remote: req.params.filename
            };

            var streamHolder = '';

            var stream = client.download(options, function (error, response) {
                if (error) {
                    return deferred.reject(error);
                } else {

                    return deferred.resolve(streamHolder);
                }
            });

            stream.on('data', function(data){
                // ToDo:  This should be refactored so that the client can receive a stream
                streamHolder += data.toString();

            });

        }
        catch (e) {
            return deferred.reject({message: e, code: 500});
        }

        return deferred.promise;
    }
/*
    function downloadStrings(app, req){
        var deferred = Q.defer(),
            body = req.body;

        if (!req.params) {
            return deferred.reject('req missing parameters');
        }

        if (!req.params.filenames) {
            return deferred.reject('req missing parameters');
        }


        try {

            var criteria;
            if (!(body.criteria instanceof Object)) {
                criteria = JSON.parse(body.criteria);
            }
            else {
                criteria = body.criteria;
            }

            var ids = base.GetSearchCriteria(criteria, 'id');

//http://code.openhub.net/file?fid=B4Fw94XUlLcweWhSSLkvC1zuZqA&cid=FPFkt7bAv-w&s=&fp=554078&mp&projSelected=true#L0
            var client = pkgcloud.storage.createClient({
                provider: app.config.storage.provider,
                username: app.config.storage.username,
                region: app.config.storage.region,
                apiKey: app.config.storage.apiKey
            });

            var options = {
                container: app.config.storage.container,
                remote: req.params.filename
            };

            var stream = client.download(options, function (error, response) {
                if (error) {
                    return deferred.reject(error);
                } else {
                    var a = response;
                }
            });

            stream.on('data', function(data){
                return deferred.resolve(data.toString());
            });

        }
        catch (e) {
            return deferred.reject({message: e, code: 500});
        }

        return deferred.promise;
    }
*/
    function removeStorage(app, remoteFilename) {
        var deferred = Q.defer();
        try {

            var client = pkgcloud.storage.createClient({
                provider: app.config.storage.provider,
                username: app.config.storage.username,
                region: app.config.storage.region,
                apiKey: app.config.storage.apiKey
            });

            client.removeFile(app.config.storage.container, remoteFilename,
                function (err, result) {
                    if (err) {
                        console.dir(err);
                        return;
                    }
                    deferred.resolve(result);
                });
        }
        catch (e) {
            return deferred.reject({message: e, code: 500});
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
                    removeStorage(app, req.params.id)
                        .then(function () {
                            return deferred.resolve(req.params.id);
                        }, function (error) {
                            return deferred.reject(error);
                        });
                },
                function (error) {
                    return deferred.reject(error);
                });
        }
        catch (e) {
            return deferred.reject({message: e, code: 400});
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
        DownloadString: downloadString
    };
};