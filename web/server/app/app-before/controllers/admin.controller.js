const db = require("../models");
const Admin = db.admin;
const Op = db.Sequelize.Op;

// Retrieve admin information
exports.findAll = (req, res) => {
    const id = req.query.id;

    var condition = {
        id: {
            [Op.eq]: id
        }
    }

    Admin.findAll({ where: condition })
    .then(data => {
        console.log(data);
        res.send(data);
    })
    .catch(err => {
        res.status(500).send({
            message: 
                err.message || "Error retrieving Admin with token=" + id
        });
    });
};