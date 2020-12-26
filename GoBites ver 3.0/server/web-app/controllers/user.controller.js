const db = require('../models');
const User = db.user;
const Op = db.Sequelize.Op;

// Retrieve all users information
exports.findAll = (req, res) => {
    User.findAll()
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving users information"
            });
        });
};

// Retrieve a user information with an id
exports.findAllSameType = (req, res) => {
    const type = req.query.type;
    console.log(type);
    var condition = {
            usertype: {
                [Op.eq]: type
            }
        }

    User.findAll({ where : condition })
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving users with type = " + type
            });
        });
};

// Retrieve a user information with an id
exports.findOne = (req, res) => {
    const id = req.query.uid;
    
    var condition = {
            UID: {
                [Op.eq]: id
            }
        }

    User.findAll({ where : condition })
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving user with id=" + id
            });
        });
};

// Update a User information with an id
exports.updateOne = (req, res) => {
    const id = req.query.uid;
  
    User.update(req.body, {
        where: { UID: id }
    })
      .then(num => {
          if (num == 1) {
              res.send({
                  message: "User information was updated successfully."
              });
          } else {
              res.send({
                  message: `User update information with id=${id}. Maybe User was not found or req.body is empty!`
              });
          }
      })
      .catch(err => {
          res.status(500).send({
              message: "Error updating User with id=" + id
          });
      });
};

// Delete a User information with an id
exports.deleteOne = (req, res) => {
    const id = req.query.rid;
  
    User.destroy({
        where: { UID: id }
    })
      .then(num => {
          if (num == 1) {
              res.send({
                  message: "User was deleted successfully!"
               });
          } else {
              res.send({
                  message: `Cannot delete User with id=${id}. Maybe User was not found!`
              });
          }
      })
      .catch(err => {
          res.status(500).send({
              message: "Could not delete User with id=" + id
          });
      });
};