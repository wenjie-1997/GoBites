const express = require("express");
const CustomerController = require("../controllers/customerController");
const router = express.Router();

router.get("/", CustomerController.getCustomersList);
router.get("/:id", CustomerController.getCustomer);
router.put("/:id", CustomerController.updateCustomer);

module.exports = router;
