const express = require("express");
const FeedbackController = require("../controllers/feedbackController");
const router = express.Router();

router.get("/restaurant/:rid", FeedbackController.getFeedbacksByRid);
router.post("/", FeedbackController.post);

module.exports = router;
