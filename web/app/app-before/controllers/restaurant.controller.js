db = require('../models');
const Restaurant = db.restaurant;

// Retrieve all restaurants information
exports.findAll = (req, res) => {
    Restaurant.findAll()
        .then(
            data => {
                res.send(data);
            }
        ).catch(
            err => {
                res.status(500).send({
                    message:
                        err.message || "Some error occurred while retrieving Restaurants information."
                });
            }
        );
};

// Retrieve a restaurant information with an id
exports.findOne = (req, res) => {
    const id = req.query.id;
  
    Restaurant.findByPk(id)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving Restaurant with id=" + id
            });
        });
};

// Update a restaurant information with an id
exports.updateOne = (req, res) => {
    const id = req.query.id;
  
    Restaurant.update(req.body, {
        where: { id: id }
    })
      .then(num => {
          if (num == 1) {
              res.send({
                  message: "Restaurant was updated successfully."
              });
          } else {
              res.send({
                  message: `Restaurant update Tutorial with id=${id}. Maybe Restaurant was not found or req.body is empty!`
              });
          }
      })
      .catch(err => {
          res.status(500).send({
              message: "Error updating Restaurant with id=" + id
          });
      });
};

// Delete a restaurant information with an id
exports.deleteOne = (req, res) => {
    const id = req.query.id;
  
    Restaurant.destroy({
        where: { id: id }
    })
      .then(num => {
          if (num == 1) {
              res.send({
                  message: "Restaurant was deleted successfully!"
               });
          } else {
              res.send({
                  message: `Cannot delete Restaurant with id=${id}. Maybe Restaurant was not found!`
              });
          }
      })
      .catch(err => {
          res.status(500).send({
              message: "Could not delete Restaurant with id=" + id
          });
      });
};