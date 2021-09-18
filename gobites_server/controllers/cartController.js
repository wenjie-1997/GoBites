const Cart = require("../models/cart");

class CartController {
  getCartList = async (req, res, next) => {
    const { cid } = req.params;
    try {
      const result = await Cart.get(cid);
      return res.json(result);
    } catch (error) {
      next(error);
    }
  };

  getCartQuantity = async (req, res, next) => {
    const { cid } = req.params;
    try {
      const result = await Cart.getQuantity(cid);
      return res.json(result);
    } catch (error) {
      next(error);
    }
  };

  deleteCartItem = async (req, res, next) => {
    const { kid } = req.params;
    try {
      const result = await Cart.delete(kid);
      return res.json(result);
    } catch (error) {
      next(error);
    }
  };

  addToCart = async (req, res, next) => {
    const { cid } = req.params;
    try {
      const result = await Cart.addToCart(cid, req.body);
      return res.json(result);
    } catch (error) {
      next(error);
    }
  };
}

module.exports = new CartController();
