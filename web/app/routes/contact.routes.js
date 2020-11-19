module.exports = app => {
    const contact = require('../controllers/contact.controller.js');

    var router = require("express").Router();

    // Retrieve a contact information with an id for a person
    router.get("/contact/person", contact.findOnePerson);

    // Retrieve a contact information with an id for an restaurant
    router.get("/contact/restaurant", contact.findOneRestaurant);

    // Update a contact information with an id
    router.put("/", contact.updateOne);

    // Delete a contact information with an id
    router.delete("/", contact.deleteOne);

    app.use("/api/contacts", router);
}