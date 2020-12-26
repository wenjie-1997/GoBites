const db = require('../models');
const MenuItem = db.menuItem;
const Op = db.Sequelize.Op;

// Retrieve all MenuItem information
exports.findAll = (req, res) => {
    MenuItem.findAll()
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving MenuItem information"
            });
        });
};

// Retrieve a MenuItem information with an MID
exports.findOne = (req, res) => {
    const id = req.query.mid;
    
    var condition = {
            MID: {
                [Op.eq]: id
            }
        }

    MenuItem.findAll({ where : condition })
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving MenuItem information with id=" + id
            });
        });
};

// Update a menuItem information with an id
exports.updateOne = (req, res) => {
    const id = req.query.mid;
  
    MenuItem.update(req.body, {
        where: { MID: id }
    })
      .then(num => {
          if (num == 1) {
              res.send({
                  message: "MenuItem was updated successfully."
              });
          } else {
              res.send({
                  message: `MenuItem update information with id=${id}. Maybe MenuItem was not found or req.body is empty!`
              });
          }
      })
      .catch(err => {
          res.status(500).send({
              message: "Error updating MenuItem with id=" + id
          });
      });
};

// Delete a MenuItem information with an id
exports.deleteOne = (req, res) => {
    const id = req.query.mid;
  
    MenuItem.destroy({
        where: { MID: id }
    })
      .then(num => {
          if (num == 1) {
              res.send({
                  message: "MenuItem was deleted successfully!"
               });
          } else {
              res.send({
                  message: `Cannot delete MenuItem with id=${id}. Maybe MenuItem was not found!`
              });
          }
      })
      .catch(err => {
          res.status(500).send({
              message: "Could not delete MenuItem with id=" + id
          });
      });
};