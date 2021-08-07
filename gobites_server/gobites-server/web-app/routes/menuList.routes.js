module.exports = app => {
    const menuList = require('../controllers/menuList.controller.js');

    var router = require("express").Router();

    router.get("/", menuList.findAll);

    router.get("/menuList", menuList.findOne);

    router.put("/", menuList.updateOne);

    router.delete("/", menuList.deleteOne);

    app.use("/api/menuLists", router);
}