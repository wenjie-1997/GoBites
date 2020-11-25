module.exports = app => {
    const address = require('../controllers/address.controller.js');

    var router = require("express").Router();

    // Retrieve a address information with an id for person
    router.get("/address/person", address.findOnePerson);

    // Retrieve a address information with an id for a restaurant
    router.get("/address/restaurant", address.findOneRestaurant);

    // Update a address information with an id
    router.put("/", address.updateOne);

    // Delete a address information with an id
    router.delete("/", address.deleteOne);

    app.use("/api/addresses", router);
}