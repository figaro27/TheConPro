'use strict';
module.exports = function (db) {
    var dto = {};
    var tableName = 'lead';

    function init() {
        dto =
        {
            id: {type: Sequelize.UUID, unique: true, primaryKey: true},
            personid: {type: Sequelize.UUID}
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

    var persmissions = {
        'read-write': 1,
        'read-only': 0
    };

    return{
        Model: model,
        Permissions: persmissions
    };
};