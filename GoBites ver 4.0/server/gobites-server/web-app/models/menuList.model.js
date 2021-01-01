const { sequelize, Sequelize } = require(".");

module.exports = (sequelize, Sequelize) => {
    const MenuList = sequelize.define("MenuList", {
        MLID: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true,
            allowNull: false
        }
    }, {
        underscore: true,
        timestamps: false,
        charset: 'utf8mb4',
        collate: 'utf8mb4_unicode_ci',
        freezeTableName: true
    });

    return MenuList;
}