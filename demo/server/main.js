const http = require("http");
const express = require("express");
const mysql = require("mysql2/promise");

let db = null;
const app = express();

const hostname = '127.0.0.1';
const port = 8000;

app.use(express.json);

app.post('login', async(req, res, next)=>{
const username = req.body.username;
const password = req.body.password;

await db.query("SELECT * FROM `user` WHERE `username`='"+username+"';");
if (error) {
    res.send({
      "code":400,
      "failed":"error ocurred"
    })
  }else{
    if(results.length > 0){
      const comparision = await bcrypt.compare(password, results[0].password)
      if(comparision){
          res.send({
            "code":200,
            "success":"login sucessfull"
          })
      }
      else{
        res.send({
             "code":204,
             "success":"Email and password does not match"
        })
      }
    }
    else{
      res.send({
        "code":206,
        "success":"User does not exits"
          });
    }
  }
  next();
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

    db.connect((err)=>{
      if(err){
        console.log(err.message);
      }
      console.log('db '+ connection.state);
    });
}

app.listen(port, () => console.log(`Listening on port ${port}...`));
main();