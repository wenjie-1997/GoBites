const Order = require("../models/order");

class OrderController {
  getOrderList = async (req, res, next) => {
    const { rid } = req.params;
    try {
      const result = await Order.get(rid);
      return res.json(result);
    } catch (error) {
      next(error);
    }
  };

  getOrderItems = async (req, res, next) => {
    const { oid } = req.params;
    try {
      const result = await Order.getOrderItems(oid);
      return res.json(result);
    } catch (error) {
      next(error);
    }
  };

  getCustOrderList = async (req, res, next) => {
    const { cid } = req.params;
    try {
      const result = await Order.getCustOrder(cid);
      return res.json(result);
    } catch (error) {
      next(error);
    }
  };

  getCustOrderItems = async (req, res, next) => {
    const { oid } = req.params;
    try {
      const result = await Order.getCustOrderItems(oid);
      return res.json(result);
    } catch (error) {
      next(error);
    }
  };

  changeOrderItemStatus = async (req, res, next) => {
    const { id } = req.params;
    try {
      const result = await Order.changeOrderItemStatus(id);
      return res.json(result);
    } catch (error) {
      next(error);
    }
  };

  setOrderToDelivering = async (req, res, next) => {
    const { oid } = req.params;
    try {
      const result = await Order.setOrderToDelivering(oid);
      return res.json(result);
    } catch (error) {
      next(error);
    }
  };

  deleteOrderItem = async (req, res, next) => {
    const { id } = req.params;
    try {
      const result = await Order.deleteOrderItem(id);
      return res.json(result);
    } catch (error) {
      next(error);
    }
  };
}

module.exports = new OrderController();
