const express = require("express");
const FeedbackController = require("../controllers/feedbackController");
const router = express.Router();

router.get("/restaurant/:rid", FeedbackController.getFeedbacksByRid);

module.exports = router;
