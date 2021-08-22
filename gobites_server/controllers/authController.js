const User = require("../models/user");

class AuthController {
  login = async (req, res, next) => {
    try {
      
      const { username, password } = req.body;
      const user = await User.login(username, password);
      console.log(user);
      if (user===null)return res.json({ user: null});

      if (user.usertype == "customer") {
        return res.json({ user });
      } else if (user.usertype == "restaurant") {
        return res.json({ user });
      } else {
        return next();
      }
    } catch (error) {
      return next(error);
    }
  };
}

module.exports = new AuthController();
