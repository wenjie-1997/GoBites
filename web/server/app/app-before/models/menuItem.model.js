const { sequelize, Sequelize } = require(".");

module.exports = (sequelize, Sequelize) => {
    const MenuItem = sequelize.define("menuItem", {
        itemName: {
            type: Sequelize.STRING(40),
            allowNull: false 
        },
        itemPrice: {
            type: Sequelize.DECIMAL(5, 2),
            allowNull: false 
        },
        itemPhoto: {
            type: Sequelize.STRING(100),
            allowNull: false 
        },
        itemDescription: {
            type: Sequelize.STRING(1000),
            allowNull: false 
        },
    }, {
        timestamps: false,
        charset: 'utf8mb4',
        collate: 'utf8mb4_unicode_ci'
    });

    return MenuItem;
}