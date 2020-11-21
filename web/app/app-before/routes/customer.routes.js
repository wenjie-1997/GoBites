module.exports = app => {
    const customers = require("../controllers/customer.controller.js");
  
    var router = require("express").Router();
  
    // Retrieve all Customers
    router.get("/", customers.findAll);
  
    // Retrieve a single Customer with id
    router.get("/customer", customers.findOne);
  
    // Update a Customer with id
    router.put("/", customers.updateOne);
  
    // Delete a Customer with id
    router.delete("/", customers.deleteOne);
  
    app.use('/api/customers', router);
  };