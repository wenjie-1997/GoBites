const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();

var corsOptions = {
  origin: "http://localhost:8081"
};

app.use(cors(corsOptions));

// parse requests of content-type - application/json
app.use(bodyParser.json());

// parse requests of content-type - application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));

const db = require("./app/models");

// // Drop existing table and re-sync database
// db.sequelize.sync({ force: true }).then(() => {
//         console.log("Drop and re-sync db.");
//     });

db.sequelize.sync().then(() => {
    console.log("sync db status: done");
});

// simple route
app.get("/", (req, res) => {
  res.json({ message: "goBites application database" });
});

require("./app/routes/user.routes")(app);
require("./app/routes/admin.routes")(app);
require("./app/routes/customer.routes")(app);
require("./app/routes/deliveryDriver.routes")(app);
require("./app/routes/restaurant.routes")(app);
require("./app/routes/people.routes")(app);
require("./app/routes/address.routes")(app);
require("./app/routes/contact.routes")(app);
// require("./app/routes/menuItem.routes")(app);
// require("./app/routes/menuList.routes")(app);

// set port, listen for requests
const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
});