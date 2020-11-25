module.exports = app => {
    const people = require('../controllers/people.controller.js');

    var router = require("express").Router();

    // Retrieve all people information
    router.get("/", people.findAll);

    // Retrieve a people information with an id
    router.get("/person", people.findOne);

    // Update a people information with an id
    router.put("/", people.updateOne);

    // Delete a people information with an id
    router.delete("/", people.deleteOne);

    app.use("/api/people", router);
}