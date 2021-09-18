const Restaurant = require("../models/restaurant");
const Feedback = require("../models/feedback");

class RestaurantController {
  getRestaurantsList = async (req, res, next) => {
    try {
      let result = await Restaurant.get();
      for (let index = 0; index < result.length; index++) {
        let rating = await Feedback.getRatingByRid(result[index].RID);
        result[index].rating = rating.rating;
      }
      res.json(result);
    } catch (e) {
      next(e);
    }
  };

  getRestaurant = async (req, res, next) => {
    try {
      const { id } = req.params;
      const result = await Restaurant.get(id);
      delete result["password"];
      return res.json(result);
    } catch (error) {
        next(error);
    }
  };

  updateRestaurant = async (req,res,next)=>{
    try {
      const { id } = req.params;
      console.log(req.body);
      const result = await Restaurant.put(id,req.body);
      console.log(result);
      return res.json(result);
    } catch (error) {
      return next(error);
    }
  }
}

module.exports = new RestaurantController();