const db = require("../db");

class Customer {
  constructor() {
    if (this.instance) return this.instance;
    Customer.instance = this;
  }

  async get() {
    const rows = await db.query(
      `SELECT * FROM customer INNER JOIN user ON user.fk_cid=customer.CID`
    );
    return this.rowToArray(rows);
  }

  async get(id) {
    const rows = await db.query(
      `SELECT * FROM customer 
      INNER JOIN user ON user.fk_cid=customer.CID 
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

module.exports = new Customer();
