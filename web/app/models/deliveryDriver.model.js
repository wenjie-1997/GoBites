const { sequelize, Sequelize } = require(".");

module.exports = (sequelize, Sequelize) => {
    const DeliveryDriver = sequelize.define("deliveryDriver", {
        deliveryDriverName: {
            type: Sequelize.STRING(50),
            allowNull: false 
        },
        deliveryDriverAge: {
            type: Sequelize.INTEGER,
            allowNull: false 
        },
        deliveryDriverGender: {
            type: Sequelize.STRING(10),
            allowNull: false 
        },
        deliveryDriverDeliveryMethod: {
            type: Sequelize.STRING(30),
            allowNull: false 
        },
        deliveryDriverWorkArea: {
            type: Sequelize.STRING(50),
            allowNull: false 
        },
        deliveryDriverAddress: {
            type: Sequelize.STRING(80),
            allowNull: false 
        },
        deliveryDriverCity: {
            type: Sequelize.STRING(30),
            allowNull: false 
        },
        deliveryDriverState: {
            type: Sequelize.STRING(20),
            allowNull: false 
        },
        deliveryDriverZipCode: {
            type: Sequelize.STRING(6),
            allowNull: false 
        },
        deliveryDriverCountry: {
            type: Sequelize.STRING(15),
            allowNull: false 
        },
        deliveryDriverEmail: {
            type: Sequelize.STRING(50),
            allowNull: false 
        },
        deliveryDriverTelephoneNo: {
            type: Sequelize.STRING(15),
            allowNull: false 
        },
    }, {
        timestamps: false,
        charset: 'utf8mb4',
        collate: 'utf8mb4_unicode_ci'
    });

    return DeliveryDriver;
};