/**
 * Created by tbbates on 7/10/14.
 */
'use strict';
module.exports = function (db) {
    var dto = {},
        tableName = 'account';

    function init() {
        dto =
        {
            id:           {type: Sequelize.UUID, unique: true, primaryKey: true},
            username:     {type: Sequelize.STRING, isEmail: true},
            password:     {type: Sequelize.STRING},
            passwordtype: {type: Sequelize.INTEGER}
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
                hooks:     db.BaseEntity.links
            });
    }

    init();

    return{
        Model: model
    };
};