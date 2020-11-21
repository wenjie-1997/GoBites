module.exports = app => {
    const deliveryDrivers = require('../controllers/deliveryDriver.controller.js');

    var router = require("express").Router();

    // Retrieve all delivery drivers information
    router.get("/", deliveryDrivers.findAll);

    // Retrieve a delivery driver information with an id
    router.get("/deliveryDriver", deliveryDrivers.findOne);

    // Update a delivery driver information with an id
    router.put("/", deliveryDrivers.updateOne);

    // Delete a delivery driver information with an id
    router.delete("/", deliveryDrivers.deleteOne);

    app.use("/api/deliveryDrivers", router);
}