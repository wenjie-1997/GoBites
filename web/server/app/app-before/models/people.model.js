const { sequelize, Sequelize } = require(".");

module.exports = (sequelize, Sequelize) => {
    const People = sequelize.define("people", {
        firstName: {
            type: Sequelize.STRING(40),
            allowNull: false 
        },
        lastName: {
            type: Sequelize.STRING(40),
            allowNull: false 
        },
        birthDate: {
            type: Sequelize.DATEONLY,
            allowNull: false 
        },
        gender: {
            type: Sequelize.STRING(10),
            allowNull: false 
        },
        age: {
            type: Sequelize.INTEGER,
            allowNull: false 
        },
        title: {
            type: Sequelize.STRING(20),
            allowNull: false 
        },
    }, {
        timestamps: false,
        charset: 'utf8mb4',
        collate: 'utf8mb4_unicode_ci',
        freezeTableName: true
    });

    return People;
}