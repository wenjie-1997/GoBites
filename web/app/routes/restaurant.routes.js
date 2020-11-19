module.exports = app => {
    const restaurants = require('../controllers/restaurant.controller.js');

    var router = require("express").Router();

    // Retrieve all delivery drivers information
    router.get("/", restaurants.findAll);

    // Retrieve a delivery driver information with an id
    router.get("/restaurant", restaurants.findOne);

    // Update a delivery driver information with an id
    router.put("/", restaurants.updateOne);

    // Delete a delivery driver information with an id
    router.delete("/", restaurants.deleteOne);

    app.use("/api/restaurants", router);
}