const { sequelize, Sequelize } = require(".");

module.exports = (sequelize, Sequelize) => {
    const Order = sequelize.define("orders", {
        orderid: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true,
            allowNull: false
        },
        totalPrice: {
            type: Sequelize.DECIMAL(5,2),
            allowNull: false
        },
    }, {
        underscore: true,
        timestamps: false,
        charset: 'utf8mb4',
        collate: 'utf8mb4_unicode_ci',
        freezeTableName: true
    });

    return Order;
}