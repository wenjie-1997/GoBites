const dbConfig = require("../config/db.config.js");

const Sequelize = require("sequelize");
const sequelize = new Sequelize(dbConfig.DB, dbConfig.USER, dbConfig.PASSWORD, {
  host: dbConfig.HOST,
  dialect: dbConfig.dialect,
  operatorsAliases: 0,

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
db.user = require("./user.model.js")(sequelize, Sequelize);
db.order = require("./order.model.js")(sequelize, Sequelize);
// db.menuList = require("./menuList.model.js")(sequelize, Sequelize);
db.menuItem = require("./menuItem.model.js")(sequelize, Sequelize);

// db.restaurant.belongsTo(db.menuList, {
//   foreignKey: 'fk_mlid',
// });

db.order.belongsTo(db.customer, {
  foreignKey: 'fk_cid',
  onDelete: 'cascade', 
  onUpdate: 'cascade',
  hooks: true,
});

db.user.belongsTo(db.customer, {
  foreignKey: 'fk_cid',
  onDelete: 'cascade', 
  onUpdate: 'cascade',
  hooks: true,
});

db.user.belongsTo(db.restaurant, {
  foreignKey: 'fk_rid',
  onDelete: 'cascade', 
  onUpdate: 'cascade',
  hooks: true,
});

// db.menuList.belongsTo(db.menuItem, {
//   foreignKey: 'fk_mid',
// });

module.exports = db;