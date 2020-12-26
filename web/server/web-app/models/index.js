const dbConfig = require("../config/db.config.js");

const Sequelize = require("sequelize");
const sequelize = new Sequelize(dbConfig.DB, dbConfig.USER, dbConfig.PASSWORD, {
  host: dbConfig.HOST,

  retry: {
      match: [
          /ETIMEDOUT/,
          /EHOSTUNREACH/,
          /ECONNRESET/,
          /ECONNREFUSED/,
          /ETIMEDOUT/,
          /ESOCKETTIMEDOUT/,
          /EHOSTUNREACH/,
          /EPIPE/,
          /EAI_AGAIN/,
          /SequelizeConnectionError/,
          /SequelizeConnectionRefusedError/,
          /SequelizeHostNotFoundError/,
          /SequelizeHostNotReachableError/,
          /SequelizeInvalidConnectionError/,
          /SequelizeConnectionTimedOutError/
      ],
      max: 5
  },

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
db.orderItem = require("./orderItem.model.js")(sequelize, Sequelize);
db.menuItem = require("./menuItem.model.js")(sequelize, Sequelize);

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

db.orderItem.belongsTo(db.menuItem, {
  foreignKey: 'fk_mid',
  onDelete: 'cascade', 
  onUpdate: 'cascade',
  hooks: true,
});

db.orderItem.belongsTo(db.order, {
  foreignKey: 'fk_oid',
  onDelete: 'cascade', 
  onUpdate: 'cascade',
  hooks: true,
});

module.exports = db;