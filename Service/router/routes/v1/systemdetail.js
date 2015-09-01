'use strict';
module.exports = function (app, path) {
    var base = require('./base')(),
        config = {
            type: 'systemdetail',
            generate: true,
            update: true,
            remove: true,
            search: true,
            simpleDelegate: false,
            simpleManager: true
        },
        manager = require('../../../data/v1/managers/simple')(config);

    function startup(){
        app.use(path, base.Router);
    }

    base.Router.post('/search', function (req, res, next) {
        return base.RestAction(app, req, res, next, manager.Search(app, req, res, next));
    });

    base.Router.post('/', app.utility.RequireRoles(['concreteprotector','subscriber','administrator']), function (req, res, next) {
        return base.RestAction(app, req, res, next, manager.Generate(app, req, res, next));
    });

    base.Router.put('/', app.utility.RequireRoles(['concreteprotector','subscriber','administrator']), function (req, res, next) {
        return base.RestAction(app, req, res, next, manager.Update(app, req, res, next));
    });

    base.Router.delete('/:id', app.utility.RequireRoles(['concreteprotector','subscriber','administrator']), function (req, res, next) {
        return base.RestAction(app, req, res, next, manager.Remove(app, req, res, next));
    });

    startup();
};