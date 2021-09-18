const express = require("express");
const OrderController = require("../controllers/orderController");
const router = express.Router();

router.get("/restaurant/:rid", OrderController.getOrderList);
router.get("/orderitems/:oid", OrderController.getOrderItems);
router.put("/orderitems/:id", OrderController.changeOrderItemStatus);
router.put("/setToDelivering/:oid", OrderController.setOrderToDelivering);
router.delete("/orderitems/:id", OrderController.deleteOrderItem);

module.exports = router;
