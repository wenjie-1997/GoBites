const mysql = require('mysql')
const { Router } = require('express')
const router = Router();
let db=null

var fs = require("fs")
const DOMAIN = "/mobile/api";

router.post(DOMAIN+'/login', async(req, res)=>{ const username = req.body.username;
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

router.post(DOMAIN+'/custregister', async(req, res)=>{
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

router.post(DOMAIN+'/restregister', async(req, res)=>{
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

router.get(DOMAIN+'/customer/:customerId', async(req, res) => {
  const cid = req.params.customerId;
  await db.query(`SELECT customer.CID,user.username,user.password,customer.custname, customer.birthdate, customer.gender, customer.address, customer.email, customer.telephoneNo, customer.image
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

router.get(DOMAIN+'/restaurant/:restaurantId', async(req, res) => {
  const rid = req.params.restaurantId;
  await db.query(`SELECT user.fk_rid as RID, user.username,user.password, restaurant.restaurantname, restaurant.ownername, restaurant.address, restaurant.restaurantstyle, restaurant.email, restaurant.telephoneNo, restaurant.image
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

router.get(DOMAIN+'/restaurants', async(req, res) => {
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

router.get(DOMAIN+'/restaurants/:rid', async(req, res) => {
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

router.get(DOMAIN+'/menu/:rid', async(req, res) => {
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

router.post(DOMAIN+'/custupdate', async(req, res)=>{
  const {CID, custname,address,email,telephoneNo} = req.body;
  let updateCusttable = "UPDATE `customer` SET `custname`=?, `address`=?,`email`=?,`telephoneNo`=? WHERE CID = ?;";
  await db.query( updateCusttable,
   [custname, address, email, telephoneNo, CID] , (error, rows, fields)=>{
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

router.post(DOMAIN+'/custupdatepassword', async(req, res)=>{
  const {password,CID} = req.body;
  await db.query( "UPDATE `user` SET password = ? WHERE fk_cid = ?;",
   [password,CID] , (error, rows, fields)=>{
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

router.post(DOMAIN+'/restupdatepassword', async(req, res)=>{
  const {password,RID} = req.body;
  await db.query( "UPDATE `user` SET password = ? WHERE fk_rid = ?;",
   [password,RID] , (error, rows, fields)=>{
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

router.post(DOMAIN+'/restupdate', async(req, res)=>{
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

router.post(DOMAIN+'/addmenu', async(req, res)=>{
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

router.post(DOMAIN+'/menuupdate', async(req, res)=>{
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

router.post(DOMAIN+'/menudelete', async(req, res)=>{
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

router.get(DOMAIN+'/viewcart/:cid', async(req, res)=>{
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

router.post(DOMAIN+'/addtocart', async(req, res)=>{
  
  const {MID, quantity, CID} = req.body;
  console.log(CID);
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


router.post(DOMAIN+'/cartdelete', async(req, res)=>{
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

router.post(DOMAIN+'/movetoorder', async(req, res)=>{
  const {CID} = req.body;
  await db.query(`INSERT INTO orders(fk_cid) VALUES(?);
  SET @last_id = LAST_INSERT_ID();
  INSERT INTO orderitem (fk_oid, fk_mid, quantity) SELECT @last_id ,fk_mid , quantity FROM cart WHERE fk_cid = ?;
  DELETE FROM cart WHERE fk_cid = ?;
  UPDATE orders SET totalPrice = 
  (SELECT SUM(menuitem.itemPrice*orderitem.quantity) FROM orderitem 
  JOIN menuitem ON menuitem.MID=orderitem.fk_mid
  WHERE fk_oid = @last_id) WHERE orderid = @last_id;
  SELECT @last_id AS OID;`,
   [CID, CID, CID] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Place an Order Failed");
        return;
    }
    else{
        console.log("Place an Order Sucessful");
        res.send(rows[5][0]);
        return;
      }
    });
});

router.get(DOMAIN+'/vieworderid/:oid', async(req, res)=>{
  const oid = req.params.oid;
  await db.query( `SELECT orderid AS OID, totalPrice, status
  FROM orders
  WHERE orderid=?`,
   [oid] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Get Order ID Failed");
        return;
    }
    else{
        console.log("Retrieve Order ID Sucessful");
        res.send(rows[0]);
        return;
      }
    });
});

router.get(DOMAIN+'/viewordername/:oid', async(req, res)=>{
  const oid = req.params.oid;
  await db.query( `SELECT menuitem.itemName, quantity, menuitem.itemPrice
  FROM orderitem
  JOIN menuitem ON menuitem.mid=orderitem.fk_mid
  WHERE fk_oid=?`,
   [oid] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Get Order Name Failed");
        return;
    }
    else{
        console.log("Retrieve Order Name Sucessful");
        res.send(rows);
        return;
      }
    });
});

router.get(DOMAIN+'/vieworderrest/:rid', async(req, res)=>{
  const rid = req.params.rid;
  await db.query( `SELECT id, menuitem.itemName, quantity, menuitem.itemPrice
  FROM orderitem
  JOIN menuitem ON menuitem.mid=orderitem.fk_mid
  WHERE menuitem.fk_rid=? AND status='PREPARING'`,
   [rid] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Get Order Name Failed");
        return;
    }
    else{
        console.log("Retrieve Order Sucessful");
        res.send(rows);
        return;
      }
    });
});

router.get(DOMAIN+'/vieworderidcust/:cid', async(req, res)=>{
  const cid = req.params.cid;
  await db.query( `SELECT orderid as OID, totalPrice, status, addedDate
  FROM orders
  WHERE fk_cid=?`,
   [cid] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Get Order ID Failed");
        return;
    }
    else{
        console.log("Retrieve Order ID Sucessful");
        res.send(rows);
        return;
      }
    });
});

router.get(DOMAIN+'/vieworderdate/:rid', async(req, res)=>{
	const rid = req.params.rid;
	await db.query(`select distinct orders.orderid as OID, orders.addedDate, orders.totalPrice from orderitem join orders on orders.orderid=orderitem.fk_oid join menuitem on menuitem.MID=orderitem.fk_mid where menuitem.fk_rid=? AND orders.status='PREPARING';
	`, [rid], (error, rows, fields)=>{
		if(error){
			console.log(error);
			res.json("get orders fail");
			return;
		}
		else{
			console.log("Retrieve order in rest success");
			res.send(rows);
			return;
		}
	})
});

router.get(DOMAIN+'/vieworderitemrest/:oid', async(req, res)=>{
  const oid = req.params.oid;
  await db.query( `SELECT id, menuitem.itemName, quantity, menuitem.itemPrice
  FROM orderitem
  JOIN menuitem ON menuitem.mid=orderitem.fk_mid
  WHERE orderitem.fk_oid=? AND status='PREPARING'`,
   [oid] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Get Order Name Failed");
        return;
    }
    else{
        console.log(rows);
        res.send(rows);
        return;
      }
    });
});

router.post(DOMAIN+'/checkusername', async(req, res)=>{
  const username = req.body.username;
  await db.query( `SELECT username FROM user WHERE username = ?`,
   [username] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Get User Name Failed");
        return;
    }
    else{
      if(rows.length > 0){
        console.log("Username exists in Database");
        res.json("Username exists in database");
        return;
        }
        else{
          console.log("Username does not exist");
        res.json("Username does not exist");
        return;
        }
      }
    });
});

router.get(DOMAIN+'/getcartquantity/:cid', async(req, res)=>{
  const cid = req.params.cid;
  await db.query( `SELECT SUM(quantity) as quantity
  FROM cart
  WHERE fk_cid=?`,
   [cid] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Get Order ID Failed");
        return;
    }
    else{
      let quantity = 0;
        console.log("Retrieve quantity Sucessful");
        if(rows[0].quantity != null){
          quantity = rows[0].quantity;
        }
        res.json(quantity);
        return;
      }
    });
});

router.post(DOMAIN+'/orderitemdelete', async(req, res)=>{
  const ID = req.body.ID;
  await db.query( `
  SET @oid = (SELECT fk_oid FROM orderitem WHERE id=?);
  DELETE FROM orderitem WHERE id=?;
  UPDATE orders SET totalPrice = 
  (SELECT SUM(menuitem.itemPrice*orderitem.quantity) FROM orderitem 
  JOIN menuitem ON menuitem.MID=orderitem.fk_mid
  WHERE fk_oid = @oid) WHERE orderid = @oid;
  DELETE FROM orders WHERE totalPrice = 0;
  `,
   [ID,ID] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Delete Order Failed");
        return;
    }
    else{
        console.log("Delete Order Sucessful");
        res.json("Delete Order Sucessful");
        return;

      }
    });
});

router.post(DOMAIN+"/restimage", async(req, res) => {
  var RID = req.body.RID;
  var name = req.body.name;
  var img = req.body.image;
  var realFile = Buffer.from(img,"base64");
  await db.query( `SELECT image FROM restaurant WHERE RID = ?`,
   [RID] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        return;
    }
    else{
      if(rows[0].image!=null){
        console.log(rows[0].image);
        var filePath = "images/"+rows[0].image;
        fs.unlinkSync(filePath);
        }
      }
    });
  
  fs.writeFile("images/" + RID + "_" + name, realFile, function (err) {
    if (err)
      console.log(err);
  });
   await db.query( `UPDATE restaurant SET image = ? WHERE RID = ?`,
   [RID+"_"+name,RID] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Upload Image Failed");
        return;
    }
    else{
        console.log("Upload Image Sucessful");
        res.json("OK");
        return;
      }
    });
 });

 router.post(DOMAIN+"/image", async(req, res) => {
  var CID = req.body.CID;
  var name = req.body.name;
  var img = req.body.image;
  var realFile = Buffer.from(img,"base64");
  await db.query( `SELECT image FROM customer WHERE CID = ?`,
   [CID] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        return;
    }
    else{
      console.log(rows[0].image);
      var filePath = "images/"+rows[0].image;
      fs.unlinkSync(filePath);
      }
    });
  
  fs.writeFile("images/" + CID + "_" + name, realFile, function (err) {
    if (err)
      console.log(err);
  });
   await db.query( `UPDATE customer SET image = ? WHERE CID = ?`,
   [CID+"_"+name,CID] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Upload Image Failed");
        return;
    }
    else{
        console.log("Upload Image Sucessful");
        res.json("OK");
        return;
      }
    });
 });

router.post(DOMAIN+'/orderitemstatus', async(req, res) => {
	const ID = req.body.ID;
	await db.query(`
	update orderitem set status = 'DONE' where id=?;`,
	[ID, ID], (error, rows, fields) => {
		if (error){
			console.log(error);
			res.json("Status change fail");
			return;
		}
		else{
			console.log('status success');
			res.json("orderitem status done");
		}
	});

});


router.post(DOMAIN+'/ordersetstatus', async(req, res) => {
	const OID = req.body.OID;
	await db.query(`
	update orders set status = 'DELIVERING' where orderid=?;`,
	[OID], (error, rows, fields) => {
		if (error){
			console.log(error);
			res.json("Status change fail");
			return;
		}
		else{
			console.log('status success');
			res.json("orders status done");
		}
	});

});


async function main(){
    db = await mysql.createConnection({
      host:"johnny.heliohost.org",
      user: "ainalfa_pharveish",
      password: "pharveish@123",
      database: "ainal_fa-go-bites-db",
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

main()
module.exports = router