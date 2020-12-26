const { sequelize, Sequelize } = require(".");

module.exports = (sequelize, Sequelize) => {
    const OrderItem = sequelize.define("orderitem", {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true,
            allowNull: false
        },
        quantity: {
            type: Sequelize.DOUBLE,
            allowNull: false
        },
        // fkOid: {
        //     type: Sequelize.INTEGER,
        //     allowNull: false,
        //     field: 'fk_oid',
        // },
        // fkMid: {
        //     type: Sequelize.INTEGER,
        //     allowNull: false,
        //     field: 'fk_mid',
        // }
    }, {
        underscore: true,
        timestamps: false,
        charset: 'utf8mb4',
        collate: 'utf8mb4_unicode_ci',
        freezeTableName: true
    });

    return OrderItem;
}