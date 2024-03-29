const express = require("express");
const db = require("./db");
const authRoute = require("./routes/auth");
const userRoute = require("./routes/user");
const customerRoute = require("./routes/customer");
const restaurantRoute = require("./routes/restaurant");
const menuRoute = require("./routes/menu");
const orderRoute = require("./routes/order");
const feedbackRoute = require("./routes/feedback");
const cartRoute = require("./routes/cart");
const fs = require("fs");

const app = express();
const port = process.env.PORT || 3000;

db.testConnection();

app.use(express.json({ limit: "50mb" }));
app.use(express.urlencoded({ extended: true, limit: "50mb" }));

app.use(express.static("images"));

app.get("/", (req, res) => res.json("Gobites Server Home"));
app.use("/auth", authRoute);
app.use("/user", userRoute);
app.use("/customer", customerRoute);
app.use("/restaurant", restaurantRoute);
app.use("/menu", menuRoute);
app.use("/order", orderRoute);
app.use("/feedback", feedbackRoute);
app.use("/cart", cartRoute);

app.listen(port, () =>
  console.log(`Access the server at http://localhost:${port}`)
);

// app.get("/customer/:customerId", async (req, res) => {
//   const cid = req.params.customerId;
//   await db.query(
//     `SELECT customer.CID,user.username,user.password,customer.custname, customer.birthdate, customer.gender, customer.address, customer.email, customer.telephoneNo, customer.image
//   FROM customer
//   INNER JOIN user ON  user.fk_cid=customer.CID
//   WHERE user.UID = ?`,
//     [cid],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Retrieve data Failed");
//         return;
//         ``;
//       } else {
//         console.log("Retreive data Sucessful");
//         res.json(rows[0]);
//         return;
//       }
//     }
//   );
// });

// app.get("/restaurant/:restaurantId", async (req, res) => {
//   const rid = req.params.restaurantId;
//   await db.query(
//     `SELECT user.fk_rid as RID, user.username,user.password, restaurant.restaurantname, restaurant.ownername, restaurant.address, restaurant.restaurantstyle, restaurant.email, restaurant.telephoneNo, restaurant.image
//   FROM restaurant
//   INNER JOIN user ON  user.fk_rid=restaurant.RID
//   WHERE user.UID = ?`,
//     [rid],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Retrieve data Failed");
//         return;
//         ``;
//       } else {
//         console.log("Retreive data Sucessful");
//         res.json(rows[0]);
//         return;
//       }
//     }
//   );
// });

// app.get("/restaurants", async (req, res) => {
//   await db.query(
//     `SELECT *
//   FROM restaurant`,
//     [],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Retrieve data Failed");
//         return;
//         ``;
//       } else {
//         console.log("Retreive data Sucessful");
//         res.json(rows);
//         return;
//       }
//     }
//   );
// });

// app.get("/restaurants/:rid", async (req, res) => {
//   const rid = req.params.rid;
//   await db.query(
//     `SELECT restaurantname, ownername, address, restaurantstyle, email, telephoneNo
//   FROM restaurant WHERE RID = ?`,
//     [rid],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Retrieve data Failed");
//         return;
//         ``;
//       } else {
//         console.log("Retreive data Sucessful");
//         res.send(rows[0]);
//         return;
//       }
//     }
//   );
// });

// app.get("/menu/:rid", async (req, res) => {
//   const rid = req.params.rid;
//   await db.query(
//     `SELECT itemName, itemPrice, itemPhoto, itemDesc, MID
//   FROM menuitem WHERE fk_rid = ?`,
//     [rid],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Retrieve data Failed");
//         return;
//         ``;
//       } else {
//         console.log("Retreive data Sucessful");
//         res.send(rows);
//         return;
//       }
//     }
//   );
// });

// app.post("/custupdate", async (req, res) => {
//   const { CID, custname, address, email, telephoneNo } = req.body;
//   let updateCusttable =
//     "UPDATE `customer` SET `custname`=?, `address`=?,`email`=?,`telephoneNo`=? WHERE CID = ?;";
//   await db.query(
//     updateCusttable,
//     [custname, address, email, telephoneNo, CID],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Update Failed");
//         return;
//       } else {
//         console.log("Update Sucessful");
//         res.json("Update Sucessful");
//         return;
//       }
//     }
//   );
// });

// app.post("/custupdatepassword", async (req, res) => {
//   const { password, CID } = req.body;
//   await db.query(
//     "UPDATE `user` SET password = ? WHERE fk_cid = ?;",
//     [password, CID],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Update Failed");
//         return;
//       } else {
//         console.log("Update Sucessful");
//         res.json("Update Sucessful");
//         return;
//       }
//     }
//   );
// });

// app.post("/restupdatepassword", async (req, res) => {
//   const { password, RID } = req.body;
//   await db.query(
//     "UPDATE `user` SET password = ? WHERE fk_rid = ?;",
//     [password, RID],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Update Failed");
//         return;
//       } else {
//         console.log("Update Sucessful");
//         res.json("Update Sucessful");
//         return;
//       }
//     }
//   );
// });

// app.post("/restupdate", async (req, res) => {
//   const {
//     RID,
//     username,
//     password,
//     restaurantname,
//     ownername,
//     restaurantstyle,
//     address,
//     email,
//     telephoneNo,
//   } = req.body;
//   let updateCusttable =
//     "UPDATE `restaurant` SET `restaurantname`=?,`ownername`=?,`restaurantstyle`=?, `address`=?,`email`=?,`telephoneNo`=? WHERE RID = ?;";
//   let updateUsertable =
//     "UPDATE `user` SET `username`=? , `password` = ? WHERE fk_rid = ?";
//   await db.query(
//     updateCusttable + updateUsertable,
//     [
//       restaurantname,
//       ownername,
//       restaurantstyle,
//       address,
//       email,
//       telephoneNo,
//       RID,
//       username,
//       password,
//       RID,
//     ],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Update Failed");
//         return;
//       } else {
//         console.log("Update Sucessful");
//         res.json("Update Sucessful");
//         return;
//       }
//     }
//   );
// });

// app.post("/addmenu", async (req, res) => {
//   const { itemName, itemPrice, itemPhoto, itemDesc, RID } = req.body;
//   await db.query(
//     "INSERT INTO `menuitem`(`itemName`, `itemPrice`, `itemPhoto`, `itemDesc`,`fk_rid`) VALUES (?,?,?,?,?)",
//     [itemName, itemPrice, itemPhoto, itemDesc, RID],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Insert Failed");
//         return;
//       } else {
//         console.log("Insert Sucessful");
//         res.json("Insert Sucessful");
//         return;
//       }
//     }
//   );
// });

// app.post("/menuupdate", async (req, res) => {
//   const { itemName, itemPrice, itemPhoto, itemDesc, MID } = req.body;
//   await db.query(
//     "UPDATE `menuitem` SET`itemName`=?,`itemPrice`=?,`itemPhoto`=?,`itemDesc`=? WHERE `MID`=?",
//     [itemName, itemPrice, itemPhoto, itemDesc, MID],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Update Failed");
//         return;
//       } else {
//         console.log("Update Sucessful");
//         res.json("Update Sucessful");
//         return;
//       }
//     }
//   );
// });

// app.post("/menudelete", async (req, res) => {
//   const { MID } = req.body;
//   await db.query(
//     "DELETE FROM `menuitem` WHERE `MID`=?",
//     [MID],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Delete Failed");
//         return;
//       } else {
//         console.log("Delete Sucessful");
//         res.json("Delete Sucessful");
//         return;
//         s;
//       }
//     }
//   );
// });

// app.get("/viewcart/:cid", async (req, res) => {
//   const cid = req.params.cid;
//   await db.query(
//     `SELECT menuitem.itemName, menuitem.itemPrice,cart.quantity,cart.KID
//   FROM cart
//   INNER JOIN menuitem ON menuitem.mid=cart.fk_mid
//   WHERE fk_cid=?`,
//     [cid],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Get Cart Failed");
//         return;
//       } else {
//         console.log("Retrieve Cart Sucessful");
//         res.send(rows);
//         return;
//       }
//     }
//   );
// });

// app.post("/addtocart", async (req, res) => {
//   const { MID, quantity, CID } = req.body;
//   console.log(CID);
//   await db.query(
//     "INSERT INTO `cart`(`fk_mid`,`quantity`,`fk_cid`) VALUES (?,?,?)",
//     [MID, quantity, CID],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Insert Failed");
//         return;
//       } else {
//         console.log("Insert Sucessful");
//         res.json("Insert Sucessful");
//         return;
//       }
//     }
//   );
// });

// app.post("/cartdelete", async (req, res) => {
//   const { KID } = req.body;
//   await db.query(
//     "DELETE FROM `cart` WHERE `KID`=?",
//     [KID],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Delete Failed");
//         return;
//       } else {
//         console.log("Delete Sucessful");
//         res.json("Delete Sucessful");
//         return;
//         s;
//       }
//     }
//   );
// });

// app.post("/movetoorder", async (req, res) => {
//   const { CID, address } = req.body;
//   await db.query(
//     `INSERT INTO orders(fk_cid,address) VALUES(?,?);
//   SET @last_id = LAST_INSERT_ID();
//   INSERT INTO orderitem (fk_oid, fk_mid, quantity) SELECT @last_id ,fk_mid , quantity FROM cart WHERE fk_cid = ?;
//   DELETE FROM cart WHERE fk_cid = ?;
//   UPDATE orders SET totalPrice =
//   (SELECT SUM(menuitem.itemPrice*orderitem.quantity) FROM orderitem
//   JOIN menuitem ON menuitem.MID=orderitem.fk_mid
//   WHERE fk_oid = @last_id) WHERE orderid = @last_id;
//   SELECT @last_id AS OID;`,
//     [CID, address, CID, CID],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Place an Order Failed");
//         return;
//       } else {
//         console.log("Place an Order Sucessful");
//         res.send(rows[5][0]);
//         return;
//       }
//     }
//   );
// });

// app.get("/vieworderid/:oid", async (req, res) => {
//   const oid = req.params.oid;
//   await db.query(
//     `SELECT orderid AS OID, totalPrice, status, addedDate, address
//   FROM orders
//   WHERE orderid=?`,
//     [oid],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Get Order ID Failed");
//         return;
//       } else {
//         console.log("Retrieve Order ID Sucessful");
//         res.send(rows[0]);
//         return;
//       }
//     }
//   );
// });

// app.get("/viewordername/:oid", async (req, res) => {
//   const oid = req.params.oid;
//   await db.query(
//     `SELECT menuitem.itemName, quantity, menuitem.itemPrice
//   FROM orderitem
//   JOIN menuitem ON menuitem.mid=orderitem.fk_mid
//   WHERE fk_oid=?`,
//     [oid],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Get Order Name Failed");
//         return;
//       } else {
//         console.log("Retrieve Order Name Sucessful");
//         res.send(rows);
//         return;
//       }
//     }
//   );
// });

// app.get("/vieworderrest/:rid", async (req, res) => {
//   const rid = req.params.rid;
//   await db.query(
//     `SELECT id, menuitem.itemName, quantity, menuitem.itemPrice
//   FROM orderitem
//   JOIN menuitem ON menuitem.mid=orderitem.fk_mid
//   WHERE menuitem.fk_rid=? AND status='PREPARING'`,
//     [rid],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Get Order Name Failed");
//         return;
//       } else {
//         console.log("Retrieve Order Sucessful");
//         res.send(rows);
//         return;
//       }
//     }
//   );
// });

// app.get("/vieworderidcust/:cid", async (req, res) => {
//   const cid = req.params.cid;
//   await db.query(
//     `SELECT orderid as OID, totalPrice, status, addedDate, address
//   FROM orders
//   WHERE fk_cid=? AND status != "DONE"`,
//     [cid],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Get Order ID Failed");
//         return;
//       } else {
//         console.log("Retrieve Order ID Sucessful");
//         res.send(rows);
//         return;
//       }
//     }
//   );
// });

// app.get("/vieworderdate/:rid", async (req, res) => {
//   const rid = req.params.rid;
//   await db.query(
//     `select distinct orders.orderid as OID, orders.addedDate, orders.totalPrice from orderitem join orders on orders.orderid=orderitem.fk_oid join menuitem on menuitem.MID=orderitem.fk_mid where menuitem.fk_rid=? AND orders.status='PREPARING';
// 	`,
//     [rid],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("get orders fail");
//         return;
//       } else {
//         console.log("Retrieve order in rest success");
//         res.send(rows);
//         return;
//       }
//     }
//   );
// });

// app.get("/vieworderitemrest/:oid", async (req, res) => {
//   const oid = req.params.oid;
//   await db.query(
//     `SELECT id, menuitem.itemName, quantity, menuitem.itemPrice
//   FROM orderitem
//   JOIN menuitem ON menuitem.mid=orderitem.fk_mid
//   WHERE orderitem.fk_oid=? AND status='PREPARING'`,
//     [oid],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Get Order Name Failed");
//         return;
//       } else {
//         console.log(rows);
//         res.send(rows);
//         return;
//       }
//     }
//   );
// });

//

// app.get("/getcartquantity/:cid", async (req, res) => {
//   const cid = req.params.cid;
//   await db.query(
//     `SELECT SUM(quantity) as quantity
//   FROM cart
//   WHERE fk_cid=?`,
//     [cid],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Get Order ID Failed");
//         return;
//       } else {
//         let quantity = 0;
//         console.log("Retrieve quantity Sucessful");
//         if (rows[0].quantity != null) {
//           quantity = rows[0].quantity;
//         }
//         res.json(quantity);
//         return;
//       }
//     }
//   );
// });

// app.post("/orderitemdelete", async (req, res) => {
//   const ID = req.body.ID;
//   await db.query(
//     `
//   SET @oid = (SELECT fk_oid FROM orderitem WHERE id=?);
//   DELETE FROM orderitem WHERE id=?;
//   UPDATE orders SET totalPrice =
//   (SELECT SUM(menuitem.itemPrice*orderitem.quantity) FROM orderitem
//   JOIN menuitem ON menuitem.MID=orderitem.fk_mid
//   WHERE fk_oid = @oid) WHERE orderid = @oid;
//   DELETE FROM orders WHERE totalPrice = 0;
//   `,
//     [ID, ID],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Delete Order Failed");
//         return;
//       } else {
//         console.log("Delete Order Sucessful");
//         res.json("Delete Order Sucessful");
//         return;
//       }
//     }
//   );
// });

// app.post("/restimage", async (req, res) => {
//   var RID = req.body.RID;
//   var name = req.body.name;
//   var img = req.body.image;
//   var realFile = Buffer.from(img, "base64");
//   await db.query(
//     `SELECT image FROM restaurant WHERE RID = ?`,
//     [RID],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         return;
//       } else {
//         if (rows[0].image != null) {
//           console.log(rows[0].image);
//           var filePath = "images/" + rows[0].image;
//           fs.unlinkSync(filePath);
//         }
//       }
//     }
//   );

//   fs.writeFile("images/" + RID + "_" + name, realFile, function (err) {
//     if (err) console.log(err);
//   });
//   await db.query(
//     `UPDATE restaurant SET image = ? WHERE RID = ?`,
//     [RID + "_" + name, RID],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Upload Image Failed");
//         return;
//       } else {
//         console.log("Upload Image Sucessful");
//         res.json("OK");
//         return;
//       }
//     }
//   );
// });

// app.post("/image", async (req, res) => {
//   var CID = req.body.CID;
//   var name = req.body.name;
//   var img = req.body.image;
//   var realFile = Buffer.from(img, "base64");
//   await db.query(
//     `SELECT image FROM customer WHERE CID = ?`,
//     [CID],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         return;
//       } else {
//         console.log(rows[0].image);
//         var filePath = "images/" + rows[0].image;
//         fs.unlinkSync(filePath);
//       }
//     }
//   );

//   fs.writeFile("images/" + CID + "_" + name, realFile, function (err) {
//     if (err) console.log(err);
//   });
//   await db.query(
//     `UPDATE customer SET image = ? WHERE CID = ?`,
//     [CID + "_" + name, CID],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Upload Image Failed");
//         return;
//       } else {
//         console.log("Upload Image Sucessful");
//         res.json("OK");
//         return;
//       }
//     }
//   );
// });

// app.post("/orderitemstatus", async (req, res) => {
//   const ID = req.body.ID;
//   await db.query(
//     `
// 	update orderitem set status = 'DONE' where id=?;`,
//     [ID, ID],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Status change fail");
//         return;
//       } else {
//         console.log("status success");
//         res.json("orderitem status done");
//       }
//     }
//   );
// });

// app.get("/vieworderstatus/:CID", async (req, res) => {
//   const CID = req.params.CID;
//   await db.query(
//     `
// 	select orders.fk_cid, orders.status, orders.deliveryNotif, orders.doneNotif from orders
// 	join customer on customer.CID=orders.fk_cid
//   INNER JOIN user ON  user.fk_cid=customer.CID
//   WHERE user.UID = ?;`,
//     [CID],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Status view fail");
//         return;
//       } else {
//         console.log("showing delivery notification");
//         if (rows[0] == null) {
//           res.json({ status: "None" });
//         } else {
//           console.log(rows[rows.length - 1]);
//           res.send(rows[rows.length - 1]);
//         }
//       }
//     }
//   );
// });

// app.post("/deliveryNotification/:CID", async (req, res) => {
//   const CID = req.params.CID;
//   await db.query(
//     `set @oid = (select orders.orderid from orders join customer on customer.CID=orders.fk_cid inner join user on user.fk_cid=customer.CID where user.UID=? order by orders.orderid desc limit 1);
// 	update orders set deliveryNotif=true where orderid=@oid;`,
//     [CID],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Status view fail");
//         return;
//       } else {
//         console.log("showing delivery notification");
//         if (rows[0] == null) {
//           res.json({ status: "None" });
//         } else {
//           res.json("notification done");
//         }
//       }
//     }
//   );
// });

// app.post("/doneNotification/:CID", async (req, res) => {
//   const CID = req.params.CID;
//   await db.query(
//     `set @oid = (select orders.orderid from orders join customer on customer.CID=orders.fk_cid inner join user on user.fk_cid=customer.CID where user.UID=? order by orders.orderid desc limit 1);
// 	update orders set doneNotif=true where orderid=@oid;`,
//     [CID],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Status view fail");
//         return;
//       } else {
//         console.log("showing delivery notification");
//         if (rows[0] == null) {
//           res.json({ status: "None" });
//         } else {
//           res.json("notification done");
//         }
//       }
//     }
//   );
// });
// app.post("/ordersetstatus", async (req, res) => {
//   const OID = req.body.OID;
//   await db.query(
//     `
// 	update orders set status = 'DELIVERING' where orderid=?;`,
//     [OID],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Status change fail");
//         return;
//       } else {
//         console.log("status success");
//         res.json("orders status done");
//       }
//     }
//   );
// });

// app.get("/viewdeliveredorderidcust/:cid", async (req, res) => {
//   const cid = req.params.cid;
//   await db.query(
//     `SELECT orderid as OID, totalPrice, status, addedDate, hasFeedback
//   FROM orders
//   WHERE fk_cid=? AND status='DONE'`,
//     [cid],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Get Order ID Failed");
//         return;
//       } else {
//         console.log("Retrieve Order ID Sucessful");
//         res.send(rows);
//         return;
//       }
//     }
//   );
// });

// app.get("/viewdeliveredorderid/:oid", async (req, res) => {
//   const oid = req.params.oid;
//   await db.query(
//     `SELECT orderid as OID, totalPrice, status, addedDate
//   FROM orders
//   WHERE orderid=?`,
//     [oid],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Get Order ID Failed");
//         return;
//       } else {
//         console.log("Retrieve Order ID Sucessful");
//         res.send(rows);
//         return;
//       }
//     }
//   );
// });

// app.post("/makerating", async (req, res) => {
//   const { rating, comment, OID, RID } = req.body;
//   console.log(rating);
//   await db.query(
//     `INSERT INTO feedback(rating, comment, oid, rid) VALUES (?,?,?,?);
//   UPDATE orders SET hasFeedback = true WHERE orderid = ?;
//   `,
//     [rating, comment, OID, RID, OID],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Rate fail");
//         return;
//       } else {
//         console.log("Rate successful");
//         res.json("Rate Successful");
//       }
//     }
//   );
// });

// app.get("/vieworderrestaurant/:oid", async (req, res) => {
//   const oid = req.params.oid;
//   await db.query(
//     `SELECT restaurant.restaurantname, restaurant.RID
//   FROM orderitem
//   JOIN menuitem ON menuitem.MID = orderitem.fk_mid
//   JOIN restaurant ON restaurant.RID = menuitem.fk_rid
//   WHERE orderitem.fk_oid=?
//   GROUP BY restaurant.restaurantname, restaurant.RID
//   `,
//     [oid],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Get Order ID Failed");
//         return;
//       } else {
//         console.log("Retrieve Order ID Sucessful");
//         res.send(rows);
//         return;
//       }
//     }
//   );
// });

// app.get("/getorderfeedback/:oid", async (req, res) => {
//   const oid = req.params.oid;
//   await db.query(
//     `SELECT fid,rating,comment,rid FROM feedback WHERE oid = ?`,
//     [oid],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Get Order ID Failed");
//         return;
//       } else {
//         console.log("Retrieve Feedback Sucessful");
//         res.send(rows[0]);
//         return;
//       }
//     }
//   );
// });

// app.get("/getrating/:rid", async (req, res) => {
//   const rid = req.params.rid;
//   await db.query(
//     `SELECT SUM(rating)/COUNT(*) as rating FROM feedback WHERE rid = ?`,
//     [rid],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Retrieve rating Failed");
//         return;
//       } else {
//         console.log("Retrieve rating Sucessful");
//         res.json(rows[0].rating);
//         return;
//       }
//     }
//   );
// });

// app.get("/getfeedbackrest/:rid", async (req, res) => {
//   const rid = req.params.rid;
//   await db.query(
//     `SELECT fid,rating,comment,rid FROM feedback WHERE rid = ?`,
//     [rid],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Retrieve Feedback Failed");
//         return;
//       } else {
//         console.log("Retrieve Feedback Sucessful");
//         res.send(rows);
//         return;
//       }
//     }
//   );
// });

// app.post("/insertorderaddress", async (req, res) => {
//   const { address, OID } = req.body;
//   await db.query(
//     `update orders set address = ? where orderid=?;`,
//     [address, OID],
//     (error, rows, fields) => {
//       if (error) {
//         console.log(error);
//         res.json("Insert Address fail");
//         return;
//       } else {
//         console.log("Insert Address successful");
//         res.json("Insert Address Successful");
//       }
//     }
//   );
// });
