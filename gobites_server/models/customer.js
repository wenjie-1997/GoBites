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

  async put(id,{custname,address,email,telephoneNo,gender,birthdate}) {
    console.log(custname);
    const rows = await db.query(
      `UPDATE customer
      SET custname = ?, address = ?, email = ?, telephoneNo = ?, gender = ?, birthdate = ?
      WHERE CID = ?`,
      [custname,address,email,telephoneNo,gender,birthdate,id]
    );
    return this.rowToArray(rows);
  }

  rowToArray(sqlRows) {
    if (!sqlRows) return null;
    return JSON.parse(JSON.stringify(sqlRows));
  }
}

module.exports = new Customer();
