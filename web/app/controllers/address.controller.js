const db = require('../models');
const Address = db.address;
const Op = db.Sequelize.Op;

// Retrieve a Address information with an id for person
exports.findOnePerson = (req, res) => {
    const id = req.query.id;
    
    var condition = {
            personId: {
                [Op.eq]: id
            }
        }

    Address.findAll({ where : condition })
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving Address with id=" + id
            });
        });
};

// Retrieve a Address information with an id for a restaurant
exports.findOneRestaurant = (req, res) => {
    const id = req.query.id;
    
    var condition = {
            restaurantId: {
                [Op.eq]: id
            }
        }

    Address.findAll({ where : condition })
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving Address with id=" + id
            });
        });
};

// Update a Address information with an id
exports.updateOne = (req, res) => {
    const id = req.query.id;
  
    Address.update(req.body, {
        where: { id: id }
    })
      .then(num => {
          if (num == 1) {
              res.send({
                  message: "Address was updated successfully."
              });
          } else {
              res.send({
                  message: `Address update Tutorial with id=${id}. Maybe Address was not found or req.body is empty!`
              });
          }
      })
      .catch(err => {
          res.status(500).send({
              message: "Error updating Address with id=" + id
          });
      });
};

// Delete a Address information with an id
exports.deleteOne = (req, res) => {
    const id = req.query.id;
  
    Address.destroy({
        where: { id: id }
    })
      .then(num => {
          if (num == 1) {
              res.send({
                  message: "Address was deleted successfully!"
               });
          } else {
              res.send({
                  message: `Cannot delete Address with id=${id}. Maybe Address was not found!`
              });
          }
      })
      .catch(err => {
          res.status(500).send({
              message: "Could not delete Address with id=" + id
          });
      });
};