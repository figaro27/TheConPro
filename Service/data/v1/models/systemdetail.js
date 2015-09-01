/**
 * Created by tbbates on 7/10/14.
 */
'use strict';
module.exports = function (db) {
    var dto = {},
        tableName = 'systemdetail';

    function init() {
        dto =
        {
            id: {type: Sequelize.UUID, unique: true, primaryKey: true},
            systemid: {type: Sequelize.UUID},
            ingredientid: {type: Sequelize.UUID},
            extra: {type: Sequelize.STRING},
            factor: {type: Sequelize.INTEGER},
            price: {type: Sequelize.STRING}
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

    return {
        Model: model
    };
};