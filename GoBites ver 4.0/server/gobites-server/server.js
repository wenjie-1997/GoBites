const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();


app.use(cors());

// parse requests of content-type - application/json
app.use(bodyParser.json());

// parse requests of content-type - application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));

const db = require("./web-app/models/index.js");

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

// website api
require("./web-app/routes/user.routes.js")(app);
require("./web-app/routes/admin.routes.js")(app);
require("./web-app/routes/restaurant.routes.js")(app);
require("./web-app/routes/customer.routes.js")(app);
require("./web-app/routes/menuItem.routes.js")(app);
require("./web-app/routes/order.routes.js")(app);

// mobile app api
app.use(require("./mobile-app/api.js"));

// set port, listen for requests
const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
});