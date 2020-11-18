const { sequelize, Sequelize } = require(".");

module.exports = (sequelize, Sequelize) => {
    const Restaurant = sequelize.define("restaurant" ,{
        restaurantName: {
            type: Sequelize.STRING(40),
            allowNull: false,
        },
        restaurantOwner: {
            type: Sequelize.STRING(40),
            allowNull: false,
        },
        restaurantAddress: {
            type: Sequelize.STRING(80),
            allowNull: false,
        },
        restaurantCity: {
            type: Sequelize.STRING(30),
            allowNull: false,
        },
        restaurantState: {
            type: Sequelize.STRING(20),
            allowNull: false,
        },
        restaurantZipCode: {
            type: Sequelize.STRING(6),
            allowNull: false,
        },
        restaurantCountry: {
            type: Sequelize.STRING(15),
            allowNull: false,
        },
        restaurantStyle: {
            type: Sequelize.STRING(50),
            allowNull: false,
        },
        restaurantEmail: {
            type: Sequelize.STRING(50),
            allowNull: false,
        },
        restaurantTelephoneNo: {
            type: Sequelize.STRING(15),
            allowNull: false,
        },
        restaurantRating: {
            type: Sequelize.FLOAT,
            allowNull: false,
        },
        restaurantTotalCustomer: {
            type: Sequelize.INTEGER,
            allowNull: false,
        }
    }, {
        timestamps: false,
        charset: 'utf8mb4',
        collate: 'utf8mb4_unicode_ci'
    });

    return Restaurant;
};