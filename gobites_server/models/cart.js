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

  async moveToOrder(cid, { address }) {
    const result = await db.query(
      `INSERT INTO orders(fk_cid,address) VALUES(?,?);
      SET @last_id = LAST_INSERT_ID();
      INSERT INTO orderitem (fk_oid, fk_mid, quantity) SELECT @last_id ,fk_mid , quantity FROM cart WHERE fk_cid = ?;
      DELETE FROM cart WHERE fk_cid = ?;
      UPDATE orders SET totalPrice =
      (SELECT SUM(menuitem.itemPrice*orderitem.quantity) FROM orderitem
      JOIN menuitem ON menuitem.MID=orderitem.fk_mid
      WHERE fk_oid = @last_id) WHERE orderid = @last_id;
      SELECT @last_id AS OID;`,
      [cid, address, cid, cid]
    );
    return this.rowToArray(result);
  }

  rowToArray(sqlRows) {
    if (!sqlRows) return null;
    return JSON.parse(JSON.stringify(sqlRows));
  }
}

module.exports = new Cart();
