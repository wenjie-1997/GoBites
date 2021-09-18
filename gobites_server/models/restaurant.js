const db = require("../db");

class Restaurant {
  constructor() {
    if (this.instance) return this.instance;
    Restaurant.instance = this;
  }

  async get(id) {
    if (id) {
      const rows = await db.query(
        `SELECT * FROM restaurant 
      INNER JOIN user ON user.fk_rid=restaurant.RID 
      WHERE user.UID = ?`,
        [id]
      );
      return this.rowToArray(rows[0]);
    }
    const rows = await db.query("SELECT * FROM restaurant");
    return this.rowToArray(rows);
  }

  async put(
    id,
    { restaurantname, ownername, address, restaurantstyle, email, telephoneNo }
  ) {
    console.log(ownername);
    const rows = await db.query(
      `UPDATE restaurant
      SET restaurantname = ?, ownername = ?, address = ?,restaurantstyle= ?, email = ?, telephoneNo = ?
      WHERE RID = ?`,
      [
        restaurantname,
        ownername,
        address,
        restaurantstyle,
        email,
        telephoneNo,
        id,
      ]
    );
    return this.rowToArray(rows);
  }

  rowToArray(sqlRows) {
    if (!sqlRows) return null;
    return JSON.parse(JSON.stringify(sqlRows));
  }
}

module.exports = new Restaurant();
