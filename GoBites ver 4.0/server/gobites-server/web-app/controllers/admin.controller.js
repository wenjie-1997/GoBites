const db = require('../models');
const Admin = db.admin;
const Op = db.Sequelize.Op;

// Retrieve admin information
exports.findOne = (req, res) => {
    const id = 1;
    
    var condition = {
        id: {
                [Op.eq]: id
            }
        }

    Admin.findAll({ where : condition })
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving admin information"
            });
        });
};