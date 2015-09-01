/**
 * Created by tbbates on 7/10/14.
 */
'use strict';
module.exports = function (db) {
    var dto = {};
    var tableName = 'projectdetail';

    function init() {
        dto =
        {
            id: {type: Sequelize.UUID, unique: true, primaryKey: true},
            projectid: {type: Sequelize.UUID},
            systemid: {type: Sequelize.UUID},
            area: {type: Sequelize.STRING},
            name: {type: Sequelize.STRING},
            arealength: {type: Sequelize.STRING},
            areawidth: {type: Sequelize.STRING},
            saleprice:{type: Sequelize.STRING},
            removed: {type: Sequelize.BOOLEAN}
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

    return{
        Model: model
    };
};