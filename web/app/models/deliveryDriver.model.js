const { sequelize, Sequelize } = require(".");

module.exports = (sequelize, Sequelize) => {
    const DeliveryDriver = sequelize.define("deliveryDriver", {
        deliveryDriverDeliveryMethod: {
            type: Sequelize.STRING(30),
            allowNull: false 
        },
        deliveryDriverWorkArea: {
            type: Sequelize.STRING(50),
            allowNull: false 
        },
    }, {
        timestamps: false,
        charset: 'utf8mb4',
        collate: 'utf8mb4_unicode_ci'
    });

    return DeliveryDriver;
};