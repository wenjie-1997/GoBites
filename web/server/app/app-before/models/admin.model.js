const { sequelize, Sequelize } = require(".");

module.exports = (sequelize, Sequelize) => {
    const Admin = sequelize.define("admin", {
        adminPrivilege: {
            type: Sequelize.STRING(50),
            allowNull: false 
        },
    }, {
        timestamps: false,
        charset: 'utf8mb4',
        collate: 'utf8mb4_unicode_ci',
        freezeTableName: true
    });

    return Admin;
}