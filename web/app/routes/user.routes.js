module.exports = app => {
    const users = require("../controllers/user.controller.js");

    var router = require("express").Router();

    // Retrieve a single user
    router.get("/", users.findOne);

    app.use('/api/users', router);
};