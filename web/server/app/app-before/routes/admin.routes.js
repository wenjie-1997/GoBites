module.exports = app => {
    const admin = require("../controllers/admin.controller.js");

    var router = require("express").Router();

    // Retrieve admin information
    router.get("/", admin.findAll);

    app.use('/api/admins', router);
};