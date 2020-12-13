const db = require('../models');
const Customer = db.customer;
const Op = db.Sequelize.Op;

// Retrieve all customers information
exports.findAll = (req, res) => {
    Customer.findAll()
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving Customers information"
            });
        });
};

// Retrieve a customer information
exports.findOne = (req, res) => {
    const id = req.query.cid;
    
    var condition = {
            CID: {
                [Op.eq]: id
            }
        }

    Customer.findAll({ where : condition })
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving customer with id=" + id
            });
        });
};

// Update a customer information
exports.updateOne = (req, res) => {
    const id = req.body.CID;
    
    Customer.update(req.body, {
        where: { CID: id }
    })
      .then(num => {
          if (num == 1) {
              res.send({
                  message: "Customer was updated successfully."
              });
          } else {
              res.send({
                  message: `Customer update information with id=${id}. Maybe Customer was not found or req.body is empty!`
              });
          }
      })
      .catch(err => {
          res.status(500).send({
              message: "Error updating Customer with id=" + id
          });
      });
};

// Delete a customer information
exports.deleteOne = (req, res) => {
    const id = req.query.cid;
    
    Customer.destroy({
        where: { CID: id }
    })
      .then(num => {
          if (num == 1) {
              res.send({
                  message: "Customer information was deleted successfully!"
               });
          } else {
              res.send({
                  message: `Cannot delete Customer information with id=${id}. Maybe Customer information was not found!`
              });
          }
      })
      .catch(err => {
          res.status(500).send({
              message: "Could not delete Customer information with id=" + id
          });
      });
};