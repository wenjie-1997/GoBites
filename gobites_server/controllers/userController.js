const User = require("../models/user");

class UserController {
  checkUsername = async (req, res) => {
    const { username } = req.body;
    try {
      const user = await User.getByUsername(username);
      if (user) return res.json({ exist: true });
      return res.json({ exist: false });
    } catch (error) {
      next(error);
    }
  };

  register = async (req, res, next) => {
    try {
      const { usertype } = req.body;
      if (usertype === "customer") {
        const result = await User.registerCustomer(req.body);
        return res.json(result);
      } else if (usertype === "restaurant") {
        const result = await User.registerRestaurant(req.body);
        return res.json(result);
      } else {
        return next();
      }
    } catch (error) {
      return next(error);
    }
  };
}

module.exports = new UserController();
