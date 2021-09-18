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
      console.log(result);
      return res.json(result);
    } catch (error) {}
  };

  updateCustomer = async (req,res,next)=>{
    try {
      const { id } = req.params;
      console.log(req.body);
      const result = await Customer.put(id,req.body);
      console.log(result);
      return res.json(result);
    } catch (error) {
      return next(error);
    }
  }
}

module.exports = new CustomerController();
