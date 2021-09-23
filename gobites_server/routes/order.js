const express = require("express");
const OrderController = require("../controllers/orderController");
const router = express.Router();

router.get("/customer/:cid", OrderController.getByCid);
router.get("/customer/delivered/:cid", OrderController.getDeliveredByCid);
router.get("/restaurant/:rid", OrderController.getOrderList);
router.get("/orderitems/:oid", OrderController.getOrderItems);
router.put("/orderitems/:id", OrderController.changeOrderItemStatus);
router.put("/setToDelivering/:oid", OrderController.setOrderToDelivering);
router.delete("/orderitems/:id", OrderController.deleteOrderItem);

module.exports = router;
