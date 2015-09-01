'use strict';
module.exports = function (db) {
    var dto = {};
    var tableName = 'phone';

    function init() {
        dto =
        {
            id: {type: Sequelize.UUID, unique: true, primaryKey: true},
            personid: {type: Sequelize.UUID},
            number: {type: Sequelize.STRING},
            type: {type: Sequelize.STRING},
            primary: {type: Sequelize.BOOLEAN}
        };

        // add added and addedby fields
        dto = _.merge(dto, db.BaseEntity.addFields);

        // add created and createdby fields
        dto = _.merge(dto, db.BaseEntity.changeFields);

        // add version fields
        dto = _.merge(dto, db.BaseEntity.versionFields);

        // add status fields
        dto = _.merge(dto, db.BaseEntity.statusFields);
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

    return{
        Model: model
    };
};