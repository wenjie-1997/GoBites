const db = require('../models');
const Restaurant = db.restaurant;
const Op = db.Sequelize.Op;

// Retrieve all restaurants information
exports.findAll = (req, res) => {
    Restaurant.findAll({
        order: [
            ['restaurantname', 'ASC']
        ]
    })
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving restaurants information"
            });
        });
};

// Retrieve a restaurant information with an id
exports.findOne = (req, res) => {
    const id = req.query.rid;
    
    var condition = {
            RID: {
                [Op.eq]: id
            }
        }

    Restaurant.findAll({ where : condition })
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving restaurant with id=" + id
            });
        });
};

// Update a restaurant information with an id
exports.updateOne = (req, res) => {
    const id = req.body.RID;
  
    Restaurant.update(req.body, {
        where: { RID: id }
    })
      .then(num => {
          if (num == 1) {
              res.send({
                  message: "Restaurant information was updated successfully."
              });
          } else {
              res.send({
                  message: `Restaurant update information with id=${id}. Maybe restaurant was not found or req.body is empty!`
              });
          }
      })
      .catch(err => {
          res.status(500).send({
              message: "Error updating Restaurant with id=" + id
          });
      });
};

// Delete a Restaurant information with an id
exports.deleteOne = (req, res) => {
    const id = req.query.rid;
  
    Restaurant.destroy({
        where: { RID: id }
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