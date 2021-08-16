const User = require("../models/user");

class AuthController {
  login = async (req, res, next) => {
    try {
      
      const { username, password } = req.body;
      const user = await User.login(username, password);
      console.log(user);
      if (user===null)return res.json({ user: null});

      if (user.usertype == "customer") {
        console.log("Login Sucessful as Customer");
        return res.json({ user });
      } else if (user.usertype == "restaurant") {
        console.log("Login Sucessful as Restaurant");

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
