const db = require('../models');
const MenuList = db.menuList;
const Op = db.Sequelize.Op;

// Retrieve all menuList information
exports.findAll = (req, res) => {
    MenuList.findAll()
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving menuList with id=" + id
            });
        });
};

// Retrieve a menuList information
exports.findOne = (req, res) => {
    const id = req.query.mlid;
    
    var condition = {
            MLID: {
                [Op.eq]: id
            }
        }

    MenuList.findAll({ where : condition })
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
    const id = req.query.mlid;
  
    MenuList.update(req.body, {
        where: { MLID: id }
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
    const id = req.query.mlid;
  
    MenuList.destroy({
        where: { MLID: id }
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