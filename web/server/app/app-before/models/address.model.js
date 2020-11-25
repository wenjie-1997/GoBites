const { sequelize, Sequelize } = require(".");

module.exports = (sequelize, Sequelize) => {
    const Address = sequelize.define("addresses", {
        detailedAddress: {
            type: Sequelize.STRING(100),
            allowNull: false 
        },
        city: {
            type: Sequelize.STRING(30),
            allowNull: false 
        },
        state: {
            type: Sequelize.STRING(40),
            allowNull: false 
        },
        zipCode: {
            type: Sequelize.STRING(6),
            allowNull: false 
        },
        country: {
            type: Sequelize.STRING(15),
            allowNull: false 
        }
    }, {
        timestamps: false,
        charset: 'utf8mb4',
        collate: 'utf8mb4_unicode_ci',
        freezeTableName: true
    });

    return Address;
}