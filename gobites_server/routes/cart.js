const express = require("express");
const CartController = require("../controllers/cartController");
const router = express.Router();

router.get("/:cid", CartController.getCartList);
router.delete("/:kid", CartController.deleteCartItem);
router.get("/quantity/:cid", CartController.getCartQuantity);
router.post("/addToCart/:cid", CartController.addToCart);
router.post("/move_to_order/:cid", CartController.moveToOrder);

module.exports = router;
