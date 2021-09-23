const express = require("express");
const router = express.Router();
const UserController = require("../controllers/userController");

router.post("/register", UserController.register);
router.post("/check_username", UserController.checkUsername);
router.post("/upload_image", UserController.uploadImage);
router.post("/check_password/:uid", UserController.checkPassword);
router.post("/update_password/:uid", UserController.updatePassword);

module.exports = router;
