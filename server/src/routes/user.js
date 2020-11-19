const { Router } = require('express')
const router = Router();

const mysqlConnection = require('../database/database')

//works
router.get('/', (req,res) => {
	res.status(200).json('Server on port 8000 and database is connected')
})

//showing user 
router.get('/:users', (req,res) => {
	mysqlConnection.query('select * from User;', (error, rows, fields) => {
		if(!error){
			res.json(rows)
		} else{
			console.log(error)
		}
	})
})

//showing user by id works
router.get('/:users/:uid', (req,res) => {
	const {UID} = req.params
	console.log(req.params)
	mysqlConnection.query('select * from User where UID = ?;', [UID], ( error, rows, fields) => {
		if(!error){
			res.json(rows)
		} else {
			console.log(error)
		}
	})
})

<<<<<<< HEAD
// register customer
router.post('/:customers', (req, res) => {
	const { custname, birthdate, gender, address, email, telephoneNo } = req.body
	console.log(req.body)
	mysqlConnection.query('insert into Customer( custname, birthdate, gender, address, email, telephoneNo) values (?,?,?,?,?,?);',
	[custname, birthdate, gender, address, email, telephoneNo ], (error, rows, fields) =>{
		if(!error){
			res.json({Status: 'Customer saved'})
		} else{
			console.log(error)
		}
	})
})

// register restaurant
router.post('/:restaurants', (req, res) => {
	const {restaurantname, ownername, address, restaurantstyle, email, telephoneNo} = req.body
	console.log(req.body)
	mysqlConnection.query('insert into Restaurant(restaurantname, ownername, address, restaurantstyle, email, telephoneNo) values (?,?,?,?,?,?);',
	[restaurantname, ownername, address, restaurantstyle, email, telephoneNo], (error, rows, fields) =>{
=======
// register user
router.post('/:users', (req, res) => {
	console.log(req)
	const {username, password, usertype} = req.body
	mysqlConnection.query('insert into User(username, password, usertype) values (?,?,?);',
	[username, password, usertype], (error, rows, fields) =>{
>>>>>>> 9c042b53f56bccce4e11619f4c0c6218f27637cf
		if(!error){
			res.json({Status: 'Restaurant saved'})
		} else{
			console.log(error)
		}
	})
})

router.put('/:users/:uid', (req, res) => {
	const {username, password, usertype} = req.body
	console.log(req.body)
	mysqlConnection.query('update User set username = ?, password = ?, usertype =?, where UID = ?;',
	[username, password, usertype], (error, rows, fields) => {
		if(!error){
			res.json({Status: 'User updated'})
		} else {
			console.log(error)
		}
	})
})

//works well
router.delete('/:users/:uid', (req, res) => {
	const {UID} = req.params;
	mysqlConnection.query('delete from User where UID =?', [UID], (error, rows, fields) => {
		if(!error){
			res.json({Status: 'User deleted'})
		} else{
			res.json({Status: error})
		}
	})
})

module.exports = router