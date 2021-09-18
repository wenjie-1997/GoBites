const db = require("../db");

class Cart {
  constructor() {
    if (this.instance) return this.instance;
    Cart.instance = this;
  }

  async get(cid) {
    const rows = await db.query(
      `SELECT menuitem.itemName, menuitem.itemPrice,cart.quantity,cart.KID
        FROM cart
        INNER JOIN menuitem ON menuitem.mid=cart.fk_mid
        WHERE fk_cid=?`,
      [cid]
    );
    return this.rowToArray(rows);
  }

  async getQuantity(cid) {
    const rows = await db.query(
      `SELECT SUM(quantity) AS quantity
      FROM cart
      WHERE fk_cid=?`,
      [cid]
    );
    return this.rowToArray(rows[0]);
  }

  async delete(kid) {
    const rows = await db.query(`DELETE FROM cart WHERE KID = ?`, [kid]);
    return this.rowToArray(rows);
  }

  async addToCart(cid, { MID, quantity }) {
    const rows = await db.query(
      "INSERT INTO `cart`(`fk_mid`,`quantity`,`fk_cid`) VALUES (?,?,?)",
      [MID, quantity, cid]
    );

    return this.rowToArray(rows);
  }

  rowToArray(sqlRows) {
    if (!sqlRows) return null;
    return JSON.parse(JSON.stringify(sqlRows));
  }
}

module.exports = new Cart();
