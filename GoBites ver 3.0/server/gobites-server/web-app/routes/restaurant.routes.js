module.exports = app => {
    const restaurant = require('../controllers/restaurant.controller.js');

    var router = require("express").Router();

    router.get("/", restaurant.findAll);

    router.get("/restaurant", restaurant.findOne);

    router.put("/", restaurant.updateOne);

    router.delete("/", restaurant.deleteOne);

    app.use("/api/restaurants", router);
}