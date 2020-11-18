const { sequelize, Sequelize } = require(".");

module.exports = (sequelize, Sequelize) => {
    const Admin = sequelize.define("admin", {
        adminName: {
            type: Sequelize.STRING(50),
            allowNull: false 
        },
        adminTitle: {
            type: Sequelize.STRING(20),
            allowNull: false,
        }
    }, {
        timestamps: false,
        charset: 'utf8mb4',
        collate: 'utf8mb4_unicode_ci'
    });

    return Admin;
}