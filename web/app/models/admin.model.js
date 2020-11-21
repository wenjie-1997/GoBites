const { sequelize, Sequelize } = require(".");

module.exports = (sequelize, Sequelize) => {
    const Admin = sequelize.define("Admin", {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true,
            allowNull: false
        },
        adminName: {
            type: Sequelize.STRING(50),
            allowNull: false
        },
        adminTitle: {
            type: Sequelize.STRING(20),
            allowNull: false
        }
    }, {
        underscore: true,
        timestamps: false,
        charset: 'utf8mb4',
        collate: 'utf8mb4_unicode_ci',
        freezeTableName: true
    });

    return Admin;
}