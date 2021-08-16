const express = require("express");
const router = express.Router();
const UserController = require("../controllers/userController");

router.post("/register", UserController.register);
router.post("/check_username", UserController.checkUsername);

module.exports = router;
