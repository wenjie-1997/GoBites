const Customer = require("../models/customer");

class CustomerController {
  getCustomersList = async (req, res, next) => {
    try {
      let result = await Customer.get();
      result = result.map((c) => {
        delete c["password"];
        return c;
      });
      res.json(result);
    } catch (e) {
      next(e);
    }
  };

  getCustomer = async (req, res, next) => {
    try {
      const { id } = req.params;
      const result = await Customer.get(id);
      delete result["password"];
      return res.json(result);
    } catch (error) {}
  };
}

module.exports = new CustomerController();
