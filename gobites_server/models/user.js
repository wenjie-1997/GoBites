const db = require(`../db`);
const fs = require("fs");

class User {
  constructor() {
    if (this.instance) return this.instance;
    User.instance = this;
  }

  async login(username, password) {
    const rows = await db.query(
      `SELECT * FROM user WHERE username=? AND password = ?`,
      [username, password]
    );
    return this.rowToArray(rows[0]);
  }

  async getByUsername(username) {
    const rows = await db.query(
      `SELECT username FROM user WHERE username = ?`,
      [username]
    );
    return this.rowToArray(rows[0]);
  }

  async checkPassword(uid) {
    const rows = await db.query(`SELECT password FROM user WHERE UID = ?`, [
      uid,
    ]);
    return this.rowToArray(rows[0]);
  }

  async updatePassword(uid,password) {
    const rows = await db.query(`UPDATE user SET password = ? WHERE UID = ?`, [
      password,uid
    ]);
    return this.rowToArray(rows);
  }

  async uploadImage({ rid, cid, name, image }) {
    const realFile = Buffer.from(image, "base64");
    let searchImgQuery = "";
    let uploadImgQuery = "";
    let id = null;

    if (rid) {
      searchImgQuery = `SELECT image FROM restaurant WHERE RID = ?`;
      uploadImgQuery = `UPDATE restaurant SET image = ? WHERE RID = ?`;
      id = rid;
    }
    if (cid) {
      searchImgQuery = `SELECT image FROM customer WHERE CID = ?`;
      uploadImgQuery = `UPDATE customer SET image = ? WHERE CID = ?`;
      id = cid;
    }
    try {
      await db.query(searchImgQuery, [id]);
      (error, rows, fields) => {
        if (error) {
          console.log(error);
          next(error);
          return;
        } else {
          if (rows[0].image != null) {
            var filePath = "images/" + rows[0].image;
            fs.unlinkSync(filePath);
          }
        }
      };

      fs.writeFile("images/" + id + "_" + name, realFile, function (err) {
        if (err) console.log(err);
      });
      const row = await db.query(uploadImgQuery, [id + "_" + name, id]);
      return this.rowToArray(row);
    } catch (error) {}
  }

  async registerCustomer({
    username,
    password,
    usertype,
    custname,
    birthdate,
    gender,
    address,
    email,
    telephoneNo,
  }) {
    let queryString = `
    INSERT INTO customer(custname, birthdate, gender, address, email, telephoneNo) VALUES (?,?,?,?,?,?); 
      SET @last_id = LAST_INSERT_ID(); 
      INSERT INTO user(username, password, usertype,fk_cid) VALUES (?, ?, ?, @last_id);`;
    const row = await db.query(queryString, [
      custname,
      birthdate,
      gender,
      address,
      email,
      telephoneNo,
      username,
      password,
      usertype,
    ]);
    return this.rowToArray(row);
  }

  async registerRestaurant({
    username,
    password,
    usertype,
    restaurantname,
    ownername,
    restaurantstyle,
    address,
    email,
    telephoneNo,
  }) {
    let queryString = `
    INSERT INTO restaurant(restaurantname,ownername,address,restaurantstyle,email,telephoneNo) VALUES (?,?,?,?,?,?); 
      SET @last_id = LAST_INSERT_ID(); 
      INSERT INTO user(username, password, usertype,fk_rid) VALUES (?, ?, ?, @last_id);`;
    const row = await db.query(queryString, [
      restaurantname,
      ownername,
      address,
      restaurantstyle,
      email,
      telephoneNo,
      username,
      password,
      usertype,
    ]);
    return this.rowToArray(row);
  }

  rowToArray(sqlRows) {
    if (!sqlRows) return null;
    return JSON.parse(JSON.stringify(sqlRows));
  }
}

module.exports = new User();
