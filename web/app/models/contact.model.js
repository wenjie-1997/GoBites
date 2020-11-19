const { sequelize, Sequelize } = require(".");

module.exports = (sequelize, Sequelize) => {
    const Contact = sequelize.define("contact", {
        email: {
            type: Sequelize.STRING(50),
            allowNull: false 
        },
        telephoneNumber: {
            type: Sequelize.STRING(15),
            allowNull: false 
        }
    }, {
        timestamps: false,
        charset: 'utf8mb4',
        collate: 'utf8mb4_unicode_ci'
    });

    return Contact;
}