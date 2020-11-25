module.exports = app => {
    const customer = require('../controllers/customer.controller.js');

    var router = require("express").Router();

    router.get("/", customer.findAll);

    router.get("/customer", customer.findOne);

    router.put("/", customer.updateOne);

    router.delete("/", customer.deleteOne);

    app.use("/api/customers", router);
}