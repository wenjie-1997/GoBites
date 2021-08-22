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
}

module.exports = new RestaurantController();