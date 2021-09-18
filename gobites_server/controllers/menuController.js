const Menu = require("../models/menu");

class MenuController {
  getMenuList = async (req, res, next) => {
    const { rid } = req.params;
    try {
      let result = await Menu.get(rid);
      return res.json(result);
    } catch (error) {
      next(error);
    }
  };

  insertMenu = async (req, res, next) => {
    try {
      let result = await Menu.post(req.body, req.params.rid);
      return res.json(result);
    } catch (error) {
      next(error);
    }
  };

  updateMenu = async (req, res, next) => {
    const { mid } = req.params;
    console.log(mid);
    try {
      const result = await Menu.put(mid, req.body);
      return res.json(result);
    } catch (error) {
      next(error);
    }
  };

  deleteMenu = async (req, res, next) => {
    const { mid } = req.params;
    try {
      const result = await Menu.delete(mid);
      return res.json(result);
    } catch (error) {
      next(error);
    }
  };
}

module.exports = new MenuController();
