const db = require("../models");
const People = db.person;

// Retrieve People from database.
exports.findAll = (req, res) => {  
    People.findAll()
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message:
                  err.message || "Some error occurred while retrieving People information."
            });
         });
};

// Find a single person with an id
exports.findOne = (req, res) => {
    const id = req.query.id;
  
    People.findByPk(id)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving Person information with id=" + id
            });
        });
};

// Update a person by the id in the request
exports.updateOne = (req, res) => {
    const id = req.query.id;
  
    People.update(req.body, {
        where: { id: id }
    })
      .then(num => {
          if (num == 1) {
              res.send({
                  message: "Person was updated successfully."
              });
          } else {
              res.send({
                  message: `Cannot update Tutorial with id=${id}. Maybe person was not found or req.body is empty!`
              });
          }
      })
      .catch(err => {
          res.status(500).send({
              message: "Error updating person with id=" + id
          });
      });
};

// Delete a person with the specified id
exports.deleteOne = (req, res) => {
    const id = req.query.id;
  
    People.destroy({
        where: { id: id }
    })
      .then(num => {
          if (num == 1) {
              res.send({
                  message: "Person was deleted successfully!"
               });
          } else {
              res.send({
                  message: `Cannot delete Person with id=${id}. Maybe Person was not found!`
              });
          }
      })
      .catch(err => {
          res.status(500).send({
              message: "Could not delete Person with id=" + id
          });
      });
};