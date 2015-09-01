'use strict';
module.exports = function (db) {
    var dto = {},
    tableName = 'ingredient';
    function init() {
        dto =
        {
            id: {type: Sequelize.UUID, unique: true, primaryKey: true},
            name: {type: Sequelize.STRING},
            coverage: {type: Sequelize.STRING},
            purchaseprice: {type: Sequelize.STRING}
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
        var result = db.Sequelize.define(
            tableName,
            dto,
            {
                tableName: tableName,
                hooks: db.BaseEntity.links
            });
        return result;
    }

    init();

    return {
        Model: model
    };
};