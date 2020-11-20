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
         console.log("Login Sucessful");
          
         res.json("Login Sucessful");
          return;
        }
        else{
          res.json("Username and/or password is not valid");
          return;
        }
      }
    });
});

app.post('/custregister', async(req, res)=>{
  const {username,password, usertype, custname,birthdate,gender,address,email,telephoneNo} = req.body;
  let insertUsertable = "INSERT INTO `user`(`username`, `password`, `usertype`,`fk_cid`) VALUES (?, ?, ?, @last_id); ";
  let setLastInsertId = "SET @last_id = LAST_INSERT_ID(); ";
  let insertCusttable = "INSERT INTO `customer`(custname,birthdate,gender,address,email,telephoneNo) VALUES (?,?,?,?,?,?); ";
  //, custname, birthDate, gender, address, telephoneNo, email
  await db.query( insertCusttable+setLastInsertId+insertUsertable,
   [custname, birthdate, gender, address, email, telephoneNo, username, password, usertype, ] , (error, rows, fields)=>{
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