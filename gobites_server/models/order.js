const db = require("../db");

class Order {
  constructor() {
    if (this.instance) return this.instance;
    Order.instance = this;
  }

  async get(rid) {
    const rows = await db.query(
      `SELECT DISTINCT orders.orderid AS OID, orders.addedDate, orders.totalPrice 
        FROM orderitem 
        JOIN orders ON orders.orderid=orderitem.fk_oid 
        JOIN menuitem ON menuitem.MID=orderitem.fk_mid
        WHERE menuitem.fk_rid=? AND orders.status='PREPARING'`,
      [rid]
    );
    return this.rowToArray(rows);
  }

  async getByCid(cid) {
    const rows = await db.query(
      `SELECT orderid as OID, totalPrice, status, addedDate, address
          FROM orders
          WHERE fk_cid=? AND status != "DONE"`,
      [cid]
    );
    return this.rowToArray(rows);
  }

  async getDeliveredByCid(cid) {
    const rows = await db.query(
      `SELECT orderid as OID, totalPrice, status, addedDate, hasFeedback, rating, comment
        FROM orders
        LEFT JOIN feedback ON orders.orderid = feedback.oid
        WHERE fk_cid=? AND status='DONE'`,
      [cid]
    );
    return this.rowToArray(rows);
  }

  async getOrderItems(oid) {
    const rows = await db.query(
      `
        SELECT id, menuitem.itemName, quantity, menuitem.itemPrice
        FROM orderitem
        JOIN menuitem ON menuitem.mid=orderitem.fk_mid
        WHERE orderitem.fk_oid=? AND status='PREPARING'`,
      [oid]
    );
    return this.rowToArray(rows);
  }

  async changeOrderItemStatus(id) {
    const rows = await db.query(
      `
	      UPDATE orderitem SET status = 'DONE' WHERE id=?;`,
      [id]
    );
    return this.rowToArray(rows);
  }

  async setOrderToDelivering(oid) {
    const row = await db.query(
      `UPDATE orders SET status = 'DELIVERING' WHERE orderid=?;`,
      [oid]
    );
    return this.rowToArray(row);
  }

  async deleteOrderItem(id) {
    const row = await db.query(
      `
            SET @oid = (SELECT fk_oid FROM orderitem WHERE id=?);
            DELETE FROM orderitem WHERE id=?;
            UPDATE orders SET totalPrice =
            (SELECT SUM(menuitem.itemPrice*orderitem.quantity) FROM orderitem
            JOIN menuitem ON menuitem.MID=orderitem.fk_mid
            WHERE fk_oid = @oid) WHERE orderid = @oid;
            DELETE FROM orders WHERE totalPrice = 0;
        `,
      [id, id]
    );
    return this.rowToArray(row);
  }

  rowToArray(sqlRows) {
    if (!sqlRows) return null;
    return JSON.parse(JSON.stringify(sqlRows));
  }
}

module.exports = new Order();
