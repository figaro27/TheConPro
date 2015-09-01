/**
 * Created by tbbates on 7/10/14.
 */
'use strict';
module.exports = function (db) {
    var dto = {};
    var tableName = 'storage';

    function init() {
        dto =
        {
            id: {type: Sequelize.UUID, unique: true, primaryKey: true},
            fid: {type: Sequelize.UUID},
            filename: {type: Sequelize.STRING},
            contenttype: {type: Sequelize.STRING},
            type: {type: Sequelize.STRING},
            hash: {type: Sequelize.STRING},
            container: {type: Sequelize.STRING},
            size: {type: Sequelize.STRING}
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