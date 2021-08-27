const Restaurant = require("../models/restaurant");

class RestaurantController {
  getRestaurantsList = async (req, res, next) => {
    try {
      let result = await Restaurant.get();
      result = result.map((c) => {
        delete c["password"];
        return c;
      });
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