const express = require("express");
const RestaurantController = require("../controllers/RestaurantController");
const router = express.Router();

router.get("/", RestaurantController.getRestaurantsList);
router.get("/:id", RestaurantController.getRestaurant);
router.get("/byOid/:oid", RestaurantController.getRestaurantByOid);
router.put("/:id", RestaurantController.updateRestaurant);

module.exports = router;
