const mysql = require('mysql')
const { Router } = require('express')
const router = Router();
let db=null

const DOMAIN = "/mobile/api";

router.post(DOMAIN + '/login', async(req, res)=>{
  const username = req.body.username;
  const password = req.body.password;
  const fk_cid = req.body.fk_cid;
  const fk_rid = req.body.fk_rid;

  await db.query("SELECT * FROM `user` WHERE `username`=? AND password = ?", [username, password] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
    }
    else{
      if(rows.length > 0){
        if(rows[0].usertype == 'customer'){
          console.log("Login Sucessful as Customer");
          
          res.send({status:"Login Sucessful as Customer",id: rows[0].UID.toString(), fk_cid: rows[0].fk_cid.toString()});
           return;
        }
        else if(rows[0].usertype == 'restaurant'){
          console.log("Login Sucessful as Restaurant");
          
          res.send({status:"Login Sucessful as Restaurant",id: rows[0].UID.toString(), fk_rid: rows[0].fk_rid.toString()});
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

router.post(DOMAIN + '/custregister', async(req, res)=>{
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

router.post(DOMAIN + '/restregister', async(req, res)=>{
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

router.get(DOMAIN + '/customer/:customerId', async(req, res) => {
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

router.get(DOMAIN + '/restaurant/:restaurantId', async(req, res) => {
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

router.get(DOMAIN + '/restaurants', async(req, res) => {
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

router.get(DOMAIN + '/restaurants/:rid', async(req, res) => {
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

router.get(DOMAIN + '/menu/:rid', async(req, res) => {
  const rid = req.params.rid;
  await db.query(`SELECT MID, itemName, itemPrice, itemPhoto, itemDesc
  FROM MenuItem WHERE fk_rid = ?`
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

router.post(DOMAIN + '/custupdate', async(req, res)=>{
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
		console.log(rows);
        res.json("Update Sucessful");
        return;
      }
    });
});

router.post(DOMAIN + '/restupdate', async(req, res)=>{
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

router.post(DOMAIN + '/addmenu', async(req, res)=>{
	const {itemName, itemPrice, itemPhoto, itemDesc, RID} = req.body;
	await db.query("INSERT INTO `MenuItem`(`itemName`, `itemPrice`, `itemPhoto`, `itemDesc`,`fk_rid`) VALUES (?,?,?,?,?)",
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

router.post(DOMAIN + '/menuupdate', async(req, res)=>{
	const {itemName, itemPrice, itemPhoto, itemDesc, MID} = req.body;
	let updateMenutable = "UPDATE `MenuItem` SET `itemName`=?, `itemPrice`=?,`itemPhoto`=?,`itemDesc`=? WHERE MID = ?";
	await db.query(updateMenutable,
	 [itemName, itemPrice, itemPhoto, itemDesc, MID] , (error, rows, fields)=>{
	  if (error) {
		  console.log(error);
		  res.json("Update Failed");
		  return;
	  }
	  else{
		  console.log("Update Successful");
		  res.json("Update Successful");
		  return;
		}
	  });
  });

router.post(DOMAIN + '/menudelete', async(req, res)=>{
  const {MID} = req.body;
  await db.query( "DELETE FROM `MenuItem` WHERE `MID`=?",
   [MID] , (error, rows, fields)=>{
    if (error) {
        console.log(error);
        res.json("Delete Failed");
        return;
    }
    else{
        console.log("Delete Successful");
        res.json("Delete Successful");
        return;
      }
    });
});

router.get(DOMAIN + '/viewcart/:cid', async(req, res)=>{
	const cid = req.params.cid;
	await db.query( `SELECT MenuItem.itemName, MenuItem.itemPrice,cart.quantity,cart.KID
	FROM cart
	INNER JOIN MenuItem ON MenuItem.mid=cart.fk_mid
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
  
  router.post(DOMAIN + '/addtocart', async(req, res)=>{
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
  
  
 router.post(DOMAIN + '/cartdelete', async(req, res)=>{
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
  
  router.post(DOMAIN + '/movetoorder', async(req, res)=>{
	const {CID} = req.body;
	await db.query(`INSERT INTO orders(fk_cid) VALUES(?);
	SET @last_id = LAST_INSERT_ID();
	INSERT INTO orderitem (fk_oid, fk_mid, quantity) SELECT @last_id ,fk_mid , quantity FROM cart WHERE fk_cid = ?;
	DELETE FROM cart WHERE fk_cid = ?;
	UPDATE orders SET totalprice = 
	(SELECT SUM(MenuItem.itemPrice*orderitem.quantity) FROM orderitem 
	JOIN MenuItem ON MenuItem.MID=orderitem.fk_mid
	WHERE fk_oid = @last_id) WHERE fk_cid = ?;
	SELECT @last_id AS OID;`,
	 [CID, CID, CID, CID] , (error, rows, fields)=>{
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
  
  router.get(DOMAIN + '/vieworderid/:oid', async(req, res)=>{
	const oid = req.params.oid;
	await db.query( `SELECT orderid AS OID, totalPrice
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
  
  router.get(DOMAIN + '/viewordername/:oid', async(req, res)=>{
	const oid = req.params.oid;
	await db.query( `SELECT MenuItem.itemName, quantity, MenuItem.itemPrice
	FROM orderitem
	JOIN MenuItem ON MenuItem.mid=orderitem.fk_mid
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


async function main(){
    db = await mysql.createConnection({
      host:"johnny.heliohost.org",
      user: "ainalfa_pharveish",
      password: "pharveish@123",
      database: "ainalfa_go-bites-db",
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
