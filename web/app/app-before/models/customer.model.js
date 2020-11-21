const { sequelize, Sequelize } = require(".");

module.exports = (sequelize, Sequelize) => {
    const Customer = sequelize.define("customer", {
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