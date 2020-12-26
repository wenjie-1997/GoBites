module.exports = app => {
    const orderItem = require('../controllers/orderItem.controller.js');

    var router = require("express").Router();

    router.get("/", orderItem.findAll);

    app.use("/api/orderItems", router);
}