const { sequelize, Sequelize } = require(".");

module.exports = (sequelize, Sequelize) => {
    const Restaurant = sequelize.define("restaurant", {
        RID: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true,
            allowNull: false
        },
        restaurantname: {
            type: Sequelize.STRING(40),
            allowNull: false
        },
        ownername: {
            type: Sequelize.STRING(40),
            allowNull: false
        },
        address: {
            type: Sequelize.STRING(100),
            allowNull: false
        },
        restaurantstyle: {
            type: Sequelize.STRING(50),
            allowNull: false
        },
        email: {
            type: Sequelize.STRING(50),
            allowNull: false
        },
        telephoneNo: {
            type: Sequelize.STRING(15),
            allowNull: false
        }
    }, {
        underscore: true,
        timestamps: false,
        charset: 'utf8mb4',
        collate: 'utf8mb4_unicode_ci',
        freezeTableName: true
    });

    return Restaurant;
}