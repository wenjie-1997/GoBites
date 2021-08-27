const db = require("../db");

class Menu {
  constructor() {
    if (this.instance) return this.instance;
    Menu.instance = this;
  }

  async get(rid) {
    const rows = await db.query(`SELECT * FROM menuitem WHERE fk_rid = ?`, [
      rid,
    ]);
    return this.rowToArray(rows);
  }

  async post({ itemName, itemPrice, itemDesc}, rid ) {
    const rows = await db.query(
      `INSERT INTO menuitem(itemName, itemPrice, itemDesc,itemPhoto,fk_rid) VALUES (?,?,?,'default.png',?)`,
      [itemName, itemPrice, itemDesc, rid]
    );
    return this.rowToArray(rows);
  }

  async put(mid, { itemName, itemPrice, itemDesc }) {
    const rows = await db.query(
      `UPDATE menuitem SET itemName = ?,itemPrice = ?, itemDesc = ? WHERE MID = ? `,
      [itemName, itemPrice, itemDesc, mid]
    );
    return this.rowToArray(rows);
  }

  async delete(mid) {
    const rows = await db.query(`DELETE FROM menuitem WHERE MID = ?`, [mid]);
    return this.rowToArray(rows);
  }

  rowToArray(sqlRows) {
    if (!sqlRows) return null;
    return JSON.parse(JSON.stringify(sqlRows));
  }
}

module.exports = new Menu();
