const dbConfig = require("../config/db.config.js");

const Sequelize = require("sequelize");
const sequelize = new Sequelize(dbConfig.DB, dbConfig.USER, dbConfig.PASSWORD, {
  host: dbConfig.HOST,
  dialect: dbConfig.dialect,
  operatorsAliases: false,

  pool: {
    max: dbConfig.pool.max,
    min: dbConfig.pool.min,
    acquire: dbConfig.pool.acquire,
    idle: dbConfig.pool.idle
  }
});

const db = {};

db.Sequelize = Sequelize;
db.sequelize = sequelize;

db.restaurant = require("./restaurant.model.js")(sequelize, Sequelize);
db.customer = require("./customer.model.js")(sequelize, Sequelize);
db.admin = require("./admin.model.js")(sequelize, Sequelize);
db.deliveryDriver = require("./deliveryDriver.model.js")(sequelize, Sequelize);
db.user = require("./user.model.js")(sequelize, Sequelize);
db.menuList = require("./menuList.model.js")(sequelize, Sequelize);
db.menuItem = require("./menuItem.model.js")(sequelize, Sequelize);
db.address = require("./address.model.js")(sequelize, Sequelize);
db.contact = require("./contact.model.js")(sequelize, Sequelize);
db.person = require("./people.model.js")(sequelize, Sequelize);

db.person.hasOne(db.address);
db.person.hasOne(db.contact);
db.person.hasOne(db.user);

db.restaurant.hasOne(db.address);
db.restaurant.hasOne(db.contact);

db.user.belongsTo(db.restaurant, {as: 'restaurantOwner'});
db.user.belongsTo(db.customer);
db.user.belongsTo(db.admin);
db.user.belongsTo(db.deliveryDriver);

db.menuList.belongsTo(db.restaurant);

db.menuItem.belongsTo(db.menuList);

module.exports = db;