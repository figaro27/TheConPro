'use strict';
module.exports = function (db) {
    var dto = {};
    var tableName = 'project';

    function init() {
        dto =
        {
            id: {type: Sequelize.UUID, unique: true, primaryKey: true},
            leadid: {type: Sequelize.UUID},
            install: {type: Sequelize.STRING},
            completed: {type: Sequelize.STRING},
            designconsult: {type: Sequelize.STRING},
            addressid: {type: Sequelize.UUID},
            projectstatus: {type: Sequelize.STRING}
        };
        // add added and addedby fields
        dto = _.merge(dto, db.BaseEntity.addFields);

        // add created and createdby fields
        dto = _.merge(dto, db.BaseEntity.changeFields);

        // add version fields
        dto = _.merge(dto, db.BaseEntity.versionFields);

        // add status fields
        dto = _.merge(dto, db.BaseEntity.statusFields);

        // add version fields
        dto = _.merge(dto, db.BaseEntity.removeFields);

    }

    function model() {
        return db.Sequelize.define(
            tableName,
            dto,
            {
                tableName: tableName,
                hooks: db.BaseEntity.links
            });
    }

    init();

    return {
        Model: model
    };
};