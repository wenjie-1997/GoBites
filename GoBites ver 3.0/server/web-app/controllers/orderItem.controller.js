const db = require('../models');
const OrderItem = db.orderItem;
const MenuItem = db.menuItem;
const Customer = db.customer;
const Order = db.order;

// Retrieve all order items information
exports.findAll = (req, res) => {
    OrderItem.findAll({
        include: [
            {
                model: MenuItem,
                attributes: ['itemName', 'itemPrice']
            },
            {
                model: Order,
                attributes: ['orderid', 'totalPrice'],
                include: [
                    {
                        model: Customer,
                        attributes: ['custname']
                    }
                ]
            }
        ],
        attributes: ['id', 'fk_oid', 'fk_mid', 'quantity']
    })
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving Order items information"
            });
        });
};