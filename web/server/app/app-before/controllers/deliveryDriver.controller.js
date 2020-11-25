db = require('../models');
const DeliveryDriver = db.deliveryDriver;

// Retrieve all delivery drivers information
exports.findAll = (req, res) => {
    DeliveryDriver.findAll()
        .then(
            data => {
                res.send(data);
            }
        ).catch(
            err => {
                rest.status(500).send({
                    message:
                        err.message || "Some error occurred while retrieving delivery drivers information."
                });
            }
        );
};

// Retrieve a delivery driver information with an id
exports.findOne = (req, res) => {
    const id = req.query.id;
  
    DeliveryDriver.findByPk(id)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving Delivery Driver with id=" + id
            });
        });
};

// Update a delivery driver information with an id
exports.updateOne = (req, res) => {
    const id = req.query.id;
  
    DeliveryDriver.update(req.body, {
        where: { id: id }
    })
      .then(num => {
          if (num == 1) {
              res.send({
                  message: "Delivery Driver was updated successfully."
              });
          } else {
              res.send({
                  message: `Delivery Driver update Tutorial with id=${id}. Maybe Delivery Driver was not found or req.body is empty!`
              });
          }
      })
      .catch(err => {
          res.status(500).send({
              message: "Error updating Delivery Driver with id=" + id
          });
      });
};

// Delete a delivery driver information with an id
exports.deleteOne = (req, res) => {
    const id = req.query.id;
  
    DeliveryDriver.destroy({
        where: { id: id }
    })
      .then(num => {
          if (num == 1) {
              res.send({
                  message: "Delivery Driver was deleted successfully!"
               });
          } else {
              res.send({
                  message: `Cannot delete Delivery Driver with id=${id}. Maybe Delivery Driver was not found!`
              });
          }
      })
      .catch(err => {
          res.status(500).send({
              message: "Could not delete Delivery Driver with id=" + id
          });
      });
};