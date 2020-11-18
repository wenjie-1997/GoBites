const { sequelize, Sequelize } = require(".");

module.exports = (sequelize, Sequelize) => {
    const Customer = sequelize.define("customer", {
        customerName: {
            type: Sequelize.STRING(40),
            allowNull: false 
        },
        customerBirthDate: {
            type: Sequelize.DATE,
            allowNull: false 
        },
        customerGender: {
            type: Sequelize.STRING(10),
            allowNull: false 
        },
        customerAddress: {
            type: Sequelize.STRING(80),
            allowNull: false 
        },
        customerCity: {
            type: Sequelize.STRING(30),
            allowNull: false 
        },
        customerState: {
            type: Sequelize.STRING(20),
            allowNull: false 
        },
        customerZipCode: {
            type: Sequelize.STRING(6),
            allowNull: false 
        },
        customerCountry: {
            type: Sequelize.STRING(15),
            allowNull: false 
        },
        customerEmail: {
            type: Sequelize.STRING(50),
            allowNull: false 
        },
        customerTelephoneNo: {
            type: Sequelize.STRING(15),
            allowNull: false 
        },
        customerTotalOrderMade: {
            type: Sequelize.INTEGER,
            allowNull: false 
        }
    }, {
        timestamps: false,
        charset: 'utf8mb4',
        collate: 'utf8mb4_unicode_ci'
    });

    return Customer;
}