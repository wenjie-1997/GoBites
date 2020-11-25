const { sequelize, Sequelize } = require(".");

module.exports = (sequelize, Sequelize) => {
    const User = sequelize.define("user", {
        userName: {
            type: Sequelize.STRING(40),
            allowNull: false 
        },
        userPassword: {
            type: Sequelize.STRING(40),
            allowNull: false 
        },
        userType: {
            type: Sequelize.STRING(20),
            allowNull: false 
        }
    }, {
        timestamps: false,
        charset: 'utf8mb4',
        collate: 'utf8mb4_unicode_ci'
    });

    return User;
}