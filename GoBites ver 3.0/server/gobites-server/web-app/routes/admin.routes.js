module.exports = app => {
    const admin = require('../controllers/admin.controller.js');

    var router = require("express").Router();

    router.get("/", admin.findOne);

    app.use("/api/admin", router);
}