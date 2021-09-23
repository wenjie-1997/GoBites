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

  async getByOid(oid) {
      const rows = await db.query(
              `SELECT restaurant.restaurantname, restaurant.RID
            FROM orderitem
            JOIN menuitem ON menuitem.MID = orderitem.fk_mid
            JOIN restaurant ON restaurant.RID = menuitem.fk_rid
            WHERE orderitem.fk_oid=?
            GROUP BY restaurant.restaurantname, restaurant.RID
            `,
        [oid]
      );
      return this.rowToArray(rows[0]);
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
