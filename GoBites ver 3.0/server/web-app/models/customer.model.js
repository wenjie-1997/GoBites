const { sequelize, Sequelize } = require(".");

module.exports = (sequelize, Sequelize) => {
    const Customer = sequelize.define("customer", {
        CID: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true,
            allowNull: false
        },
        custname: {
            type: Sequelize.STRING(50),
            allowNull: false
        },
        birthdate: {
            type: Sequelize.DATEONLY,
            allowNull: false
        },
        gender: {
            type: Sequelize.STRING(50),
            allowNull: false
        },
        address: {
            type: Sequelize.STRING(50),
            allowNull: false
        },
        email: {
            type: Sequelize.STRING(50),
            allowNull: false
        },
        telephoneNo: {
            type: Sequelize.STRING(50),
            allowNull: false
        },
    }, {
        underscore: true,
        timestamps: false,
        charset: 'utf8mb4',
        collate: 'utf8mb4_unicode_ci',
        freezeTableName: true
    });

    return Customer;
}