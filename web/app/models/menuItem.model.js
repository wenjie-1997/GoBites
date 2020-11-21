const { sequelize, Sequelize } = require(".");

module.exports = (sequelize, Sequelize) => {
    const MenuItem = sequelize.define("MenuItem", {
        MID: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true,
            allowNull: false
        },
        itemName: {
            type: Sequelize.STRING(40),
            allowNull: false
        },
        itemPrice: {
            type: Sequelize.DECIMAL(5,2),
            allowNull: false
        },
        itemPhoto: {
            type: Sequelize.STRING(100),
            allowNull: false
        },
        itemDesc: {
            type: Sequelize.STRING(1000),
            allowNull: false
        }
    }, {
        underscore: true,
        timestamps: false,
        charset: 'utf8mb4',
        collate: 'utf8mb4_unicode_ci',
        freezeTableName: true
    });

    return MenuItem;
}