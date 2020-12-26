module.exports = app => {
    const menuItem = require('../controllers/menuItem.controller.js');

    var router = require("express").Router();

    router.get("/", menuItem.findAll);

    router.get("/menuItem", menuItem.findOne);

    router.put("/", menuItem.updateOne);

    router.delete("/", menuItem.deleteOne);

    app.use("/api/menuItems", router);
}