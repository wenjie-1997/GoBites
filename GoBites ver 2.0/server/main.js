const express = require("express");
const mysql = require("mysql");
let db = null;

// create express app
const app = express();
app.use(express.json());
// Setup server port
const port = process.env.PORT || 8000;

app.post('/login', async(req, res)=>{
  const username = req.body.username;
  const password = req.body.password;

  await db.query("SELECT * FROM `user` WHERE `username`=? AND password = ?", [username, password] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
    }
    else{
      if(rows.length > 0){
        if(rows[0].usertype == 'customer'){
          console.log("Login Sucessful as Customer");
          res.send({status:"Login Sucessful as Customer",id: rows[0].UID.toString()});
           return;
        }
        else if(rows[0].usertype == 'restaurant'){
          console.log("Login Sucessful as Restaurant");
          
          res.send({status:"Login Sucessful as Restaurant",id: rows[0].UID.toString()});
           return;
        }
         
      }
      else{
        res.send({status:"Fail to Login",id:null});
        return;
      }
      }
    });
});

app.post('/custregister', async(req, res)=>{
  const {username,password, usertype, custname,birthdate,gender,address,email,telephoneNo} = req.body;
  let insertUsertable = "INSERT INTO `user`(`username`, `password`, `usertype`,`fk_cid`) VALUES (?, ?, ?, @last_id); ";
  let setLastInsertId = "SET @last_id = LAST_INSERT_ID(); ";
  let insertCusttable = "INSERT INTO `customer`(custname, birthdate, gender, address, email, telephoneNo) VALUES (?,?,?,?,?,?); ";
  //, custname, birthDate, gender, address, telephoneNo, email
  await db.query( insertCusttable+setLastInsertId+insertUsertable,
   [custname, birthdate, gender, address, email, telephoneNo, username, password, usertype] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Register Failed");
        return;
    }
    else{
        console.log("Register Sucessful");
        res.json("Register Sucessful");
        return;
      }
    });
});

app.post('/restregister', async(req, res)=>{
  const {username,password, usertype, restaurantname,ownername,address,restaurantstyle,email,telephoneNo} = req.body;
  let insertUsertable = "INSERT INTO `user`(`username`, `password`, `usertype`,`fk_rid`) VALUES (?, ?, ?, @last_id); ";
  let setLastInsertId = "SET @last_id = LAST_INSERT_ID(); ";
  let insertCusttable = "INSERT INTO `restaurant`(restaurantname,ownername,address,restaurantstyle,email,telephoneNo) VALUES (?,?,?,?,?,?); ";
  await db.query( insertCusttable+setLastInsertId+insertUsertable,
   [restaurantname,ownername,address,restaurantstyle,email,telephoneNo, username, password, usertype, ] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Register Failed");
    }
    else{
        console.log("Register Sucessful");
        res.json("Register Sucessful");
      }
    });
});

app.get('/customer/:customerId', async(req, res) => {
  const cid = req.params.customerId;
  await db.query(`SELECT customer.CID,user.username,user.password,customer.custname, customer.birthdate, customer.gender, customer.address, customer.email, customer.telephoneNo
  FROM customer
  INNER JOIN user ON  user.fk_cid=customer.CID
  WHERE user.UID = ?`
  , [cid], (error, rows, fields) => {
    if (error) {
      console.log(error);
      res.json("Retrieve data Failed");
      return;
  ``}
    else{
      console.log("Retreive data Sucessful");
      res.json(rows[0]);
      return;
    }
  });
});

app.get('/restaurant/:restaurantId', async(req, res) => {
  const rid = req.params.restaurantId;
  await db.query(`SELECT user.fk_rid as RID, user.username,user.password, restaurant.restaurantname, restaurant.ownername, restaurant.address, restaurant.restaurantstyle, restaurant.email, restaurant.telephoneNo
  FROM restaurant
  INNER JOIN user ON  user.fk_rid=restaurant.RID
  WHERE user.UID = ?`
  , [rid], (error, rows, fields) => {
    if (error) {
      console.log(error);
      res.json("Retrieve data Failed");
      return;
  ``}
    else{
      console.log("Retreive data Sucessful");
      res.json(rows[0]);
      return;
    }
  });
});

app.get('/restaurants', async(req, res) => {
  await db.query(`SELECT RID,restaurantname
  FROM restaurant`
  , [], (error, rows, fields) => {
    if (error) {
      console.log(error);
      res.json("Retrieve data Failed");
      return;
  ``}
    else{
      console.log("Retreive data Sucessful");
      res.json(rows);
      return;
    }
  });
});

app.get('/restaurants/:rid', async(req, res) => {
  const rid = req.params.rid;
  await db.query(`SELECT restaurantname, ownername, address, restaurantstyle, email, telephoneNo
  FROM restaurant WHERE RID = ?`
  , [rid], (error, rows, fields) => {
    if (error) {
      console.log(error);
      res.json("Retrieve data Failed");
      return;
  ``}
    else{
      console.log("Retreive data Sucessful");
      res.send(rows[0]);
      return;
    }
  });
});

app.get('/menu/:rid', async(req, res) => {
  const rid = req.params.rid;
  await db.query(`SELECT itemName, itemPrice, itemPhoto, itemDesc, MID
  FROM menuitem WHERE fk_rid = ?`
  , [rid], (error, rows, fields) => {
    if (error) {
      console.log(error);
      res.json("Retrieve data Failed");
      return;
  ``}
    else{
      console.log("Retreive data Sucessful");
      res.send(rows);
      return;
    }
  });
});

app.post('/custupdate', async(req, res)=>{
  const {CID, username,password, custname,address,email,telephoneNo} = req.body;
  let updateCusttable = "UPDATE `customer` SET `custname`=?, `address`=?,`email`=?,`telephoneNo`=? WHERE CID = ?;";
  let updateUsertable = "UPDATE `user` SET `username`=? , `password` = ? WHERE fk_cid = ?";
  await db.query( updateCusttable + updateUsertable,
   [custname, address, email, telephoneNo, CID, username, password, CID] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Update Failed");
        return;
    }
    else{
        console.log("Update Sucessful");
        res.json("Update Sucessful");
        return;
      }
    });
});

app.post('/restupdate', async(req, res)=>{
  const {RID, username, password, restaurantname, ownername, restaurantstyle, address, email, telephoneNo} = req.body;
  let updateCusttable = "UPDATE `restaurant` SET `restaurantname`=?,`ownername`=?,`restaurantstyle`=?, `address`=?,`email`=?,`telephoneNo`=? WHERE RID = ?;";
  let updateUsertable = "UPDATE `user` SET `username`=? , `password` = ? WHERE fk_rid = ?";
  await db.query( updateCusttable + updateUsertable,
   [restaurantname, ownername, restaurantstyle, address, email, telephoneNo, RID, username, password, RID] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Update Failed");
        return;
    }
    else{
        console.log("Update Sucessful");
        res.json("Update Sucessful");
        return;
      }
    });
});

app.post('/addmenu', async(req, res)=>{
  const {itemName, itemPrice, itemPhoto, itemDesc, RID} = req.body;
  await db.query("INSERT INTO `menuitem`(`itemName`, `itemPrice`, `itemPhoto`, `itemDesc`,`fk_rid`) VALUES (?,?,?,?,?)",
   [itemName, itemPrice, itemPhoto, itemDesc,RID] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Insert Failed");
        return;
    }
    else{
        console.log("Insert Sucessful");
        res.json("Insert Sucessful");
        return;
      }
    });
});

app.post('/menuupdate', async(req, res)=>{
  const {itemName, itemPrice, itemPhoto, itemDesc, MID} = req.body;
  await db.query( "UPDATE `menuitem` SET`itemName`=?,`itemPrice`=?,`itemPhoto`=?,`itemDesc`=? WHERE `MID`=?",
   [itemName, itemPrice, itemPhoto, itemDesc, MID] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Update Failed");
        return;
    }
    else{
        console.log("Update Sucessful");
        res.json("Update Sucessful");
        return;
      }
    });
});

app.post('/menudelete', async(req, res)=>{
  const {MID} = req.body;
  await db.query( "DELETE FROM `menuitem` WHERE `MID`=?",
   [MID] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Delete Failed");
        return;
    }
    else{
        console.log("Delete Sucessful");
        res.json("Delete Sucessful");
        return;s
      }
    });
});

app.get('/viewcart/:cid', async(req, res)=>{
  const cid = req.params.cid;
  await db.query( `SELECT menuitem.itemName, menuitem.itemPrice,cart.quantity,cart.KID
  FROM cart
  INNER JOIN menuitem ON menuitem.mid=cart.fk_mid
  WHERE fk_cid=?`,
   [cid] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Get Cart Failed");
        return;
    }
    else{
        console.log("Retrieve Cart Sucessful");
        res.send(rows);
        return;
      }
    });
});

app.post('/addtocart', async(req, res)=>{
  const {MID, quantity, CID} = req.body;
  await db.query("INSERT INTO `cart`(`fk_mid`,`quantity`,`fk_cid`) VALUES (?,?,?)",
   [MID, quantity, CID] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Insert Failed");
        return;
    }
    else{
        console.log("Insert Sucessful");
        res.json("Insert Sucessful");
        return;
      }
    });
});


app.post('/cartdelete', async(req, res)=>{
  const {KID} = req.body;
  await db.query( "DELETE FROM `cart` WHERE `KID`=?",
   [KID] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Delete Failed");
        return;
    }
    else{
        console.log("Delete Sucessful");
        res.json("Delete Sucessful");
        return;s
      }
    });
});

app.post('/movetoorder', async(req, res)=>{
  const {CID} = req.body;
  await db.query(`INSERT INTO orders(fk_cid) VALUES(?);
  SET @last_id = LAST_INSERT_ID();
  INSERT INTO orderitem (fk_oid, fk_mid, quantity) SELECT @last_id ,fk_mid , quantity FROM cart WHERE fk_cid = ?;
  DELETE FROM cart WHERE fk_cid = ?;
  UPDATE orders SET totalprice = 
  (SELECT SUM(menuitem.itemPrice*orderitem.quantity) FROM orderitem 
  JOIN menuitem ON menuitem.MID=orderitem.fk_mid
  WHERE fk_oid = @last_id) WHERE fk_cid = ?;
  SELECT @last_id AS MID;`,
   [CID, CID, CID, CID] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Place an Order Failed");
        return;
    }
    else{
        console.log("Place an Order Sucessful");
        res.json("Place an Order Sucessful");
        return;
      }
    });
});

app.get('/', (req, res) => {
  res.send("Hello World");
});

async function main(){
    db = await mysql.createConnection({
      host:"localhost",
      user: "root",
      password: "",
      database: "gobites",
      timezone: "+00:00",
      charset: "utf8mb4_general_ci",
      multipleStatements: true
    });

    db.connect(function (error) {
      if(error){
          console.log(error);
          return;
      } else {
          console.log('Database is connected');
      }
    });
}

app.listen(port, () => console.log(`Listening on port ${port}...`));
main();