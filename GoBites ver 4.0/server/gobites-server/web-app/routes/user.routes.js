module.exports = app => {
    const user = require('../controllers/user.controller.js');

    var router = require("express").Router();

    router.get("/", user.findAll);

    router.get("/user", user.findOne);

    router.get("/type", user.findAllSameType);

    router.put("/", user.updateOne);

    router.delete("/", user.deleteOne);

    app.use("/api/users", router);
}