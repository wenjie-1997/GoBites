const { sequelize, Sequelize } = require(".");

module.exports = (sequelize, Sequelize) => {
    const MenuList = sequelize.define("menuList", {
    }, {
        timestamps: false,
        charset: 'utf8mb4',
        collate: 'utf8mb4_unicode_ci'
    });

    return MenuList;
}