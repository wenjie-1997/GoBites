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
  await db.query(`SELECT user.username,user.password,customer.custname, customer.birthdate, customer.gender, customer.address, customer.email, customer.telephoneNo
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
  await db.query(`SELECT user.username,user.password, restaurant.restaurantname, restaurant.ownername, restaurant.address, restaurant.restaurantstyle, restaurant.email, restaurant.telephoneNo
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
  const rid = req.params.restaurantId;
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
      res.json(rows);
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