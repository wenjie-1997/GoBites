const Feedback = require('../models/feedback');

class FeedbackController{
    getFeedbacksByRid = async(req,res,next)=>{
        const {rid} = req.params;
        try {
            const result = await Feedback.getByRid(rid);
            return res.json(result);
        } catch (error) {
            next(error);
        }
    }
}

module.exports = new FeedbackController();