const express = require("express");
const MenuController = require("../controllers/menuController");
const router = express.Router();

router.get("/:rid", MenuController.getMenuList);
router.post("/:rid", MenuController.insertMenu);
router.put("/:mid", MenuController.updateMenu);
router.delete("/:mid", MenuController.deleteMenu);

module.exports = router;
