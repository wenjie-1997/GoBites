const db = require(`../db`);

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
