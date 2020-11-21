const db = require("../models");
const Customer = db.customer;

// Retrieve all Customers from database.
exports.findAll = (req, res) => {  
    Customer.findAll()
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message:
                  err.message || "Some error occurred while retrieving customers information."
            });
         });
};

// Find a single Customer with an id
exports.findOne = (req, res) => {
    const id = req.query.id;
  
    Customer.findByPk(id)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving Customer with id=" + id
            });
        });
};

// Update a Customer by the id in the request
exports.updateOne = (req, res) => {
    const id = req.query.id;
  
    Customer.update(req.body, {
        where: { id: id }
    })
      .then(num => {
          if (num == 1) {
              res.send({
                  message: "Customer was updated successfully."
              });
          } else {
              res.send({
                  message: `Cannot update Tutorial with id=${id}. Maybe Customer was not found or req.body is empty!`
              });
          }
      })
      .catch(err => {
          res.status(500).send({
              message: "Error updating Customer with id=" + id
          });
      });
};

// Delete a Customer with the specified id
exports.deleteOne = (req, res) => {
    const id = req.query.id;
  
    Customer.destroy({
        where: { id: id }
    })
      .then(num => {
          if (num == 1) {
              res.send({
                  message: "Customer was deleted successfully!"
               });
          } else {
              res.send({
                  message: `Cannot delete Customer with id=${id}. Maybe Customer was not found!`
              });
          }
      })
      .catch(err => {
          res.status(500).send({
              message: "Could not delete Customer with id=" + id
          });
      });
};