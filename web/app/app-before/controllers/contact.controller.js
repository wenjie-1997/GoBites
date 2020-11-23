const db = require('../models');
const Contact = db.contact;
const Op = db.Sequelize.Op;

// Retrieve a contact information with an id for person
exports.findOnePerson = (req, res) => {
    const id = req.query.id;
    
    var condition = {
            personId: {
                [Op.eq]: id
            }
        }

    Contact.findAll({ where : condition })
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving Contact with id=" + id
            });
        });
};

// Retrieve a contact information with an id for a restaurant
exports.findOneRestaurant = (req, res) => {
    const id = req.query.id;
    
    var condition = {
            restaurantId: {
                [Op.eq]: id
            }
        }

    Contact.findAll({ where : condition })
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving Contact with id=" + id
            });
        });
};

// Update a contact information with an id
exports.updateOne = (req, res) => {
    const id = req.query.id;
  
    Contact.update(req.body, {
        where: { id: id }
    })
      .then(num => {
          if (num == 1) {
              res.send({
                  message: "Contact was updated successfully."
              });
          } else {
              res.send({
                  message: `Contact update Tutorial with id=${id}. Maybe Contact was not found or req.body is empty!`
              });
          }
      })
      .catch(err => {
          res.status(500).send({
              message: "Error updating Contact with id=" + id
          });
      });
};

// Delete a contact information with an id
exports.deleteOne = (req, res) => {
    const id = req.query.id;
  
    Contact.destroy({
        where: { id: id }
    })
      .then(num => {
          if (num == 1) {
              res.send({
                  message: "Contact was deleted successfully!"
               });
          } else {
              res.send({
                  message: `Cannot delete Contact with id=${id}. Maybe Contact was not found!`
              });
          }
      })
      .catch(err => {
          res.status(500).send({
              message: "Could not delete Contact with id=" + id
          });
      });
};