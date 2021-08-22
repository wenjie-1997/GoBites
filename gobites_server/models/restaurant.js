const db = require("../db");

class Restaurant {
  constructor() {
    if (this.instance) return this.instance;
    Restaurant.instance = this;
  }

  async get() {
    const rows = await db.query(
      `SELECT * FROM restaurant INNER JOIN user ON user.fk_rid=restaurant.RID`
    );
    return this.rowToArray(rows);
  }

  async get(id) {
    const rows = await db.query(
      `SELECT * FROM restaurant 
      INNER JOIN user ON user.fk_rid=restaurant.RID 
      WHERE user.UID = ?`,
      [id]
    );
    return this.rowToArray(rows[0]);
  }

  rowToArray(sqlRows) {
    if (!sqlRows) return null;
    return JSON.parse(JSON.stringify(sqlRows));
  }
}

module.exports = new Restaurant();