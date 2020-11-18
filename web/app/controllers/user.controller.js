const db = require("../models");
const User = db.user;
const Op = db.Sequelize.Op;

// Retrieve a single user with an id and type of user
exports.findOne = (req, res) => {
    const id = req.query.id;
    const type = req.query.type;

    var condition = {
        [Op.and]: [
            {
                userType : {
                    [Op.eq]: type
                }
            },
            {
                adminId : {
                    [Op.eq]: id
                }
            }
        ]
    }

    User.findAll({ where: condition})
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: err.message || `Some errors occur while retrieving ${type} with id=${id}`
            })
        });
}