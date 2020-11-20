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
          res.jsonEncode("Username and/or password is not valid");
          return;
        }
      }
    });
});

app.post('/custregister', async(req, res)=>{
  const {username,password, usertype} = req.body;
  //, custname, birthDate, gender, address, telephoneNo, email
  await db.query("INSERT INTO `user`(`username`, `password`, `usertype`) VALUES (?, ?, ?); INSERT INTO `customer`(custname,birthdate,gender,address,email,telephoneNo) VALUES (?,?,?,?,?,?); "
  , [username, password, usertype] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
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