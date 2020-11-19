const { sequelize, Sequelize } = require(".");

module.exports = (sequelize, Sequelize) => {
    const Restaurant = sequelize.define("restaurant" ,{
        restaurantName: {
            type: Sequelize.STRING(100),
            allowNull: false,
        },
        restaurantStyle: {
            type: Sequelize.STRING(50),
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