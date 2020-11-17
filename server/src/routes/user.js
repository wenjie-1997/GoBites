const { Router } = require('express')
const router = Router();

const mysqlConnection = require('../database/database')

//works
router.get('/', (req,res) => {
	res.status(200).json('Server on port 8000 and database is connected')
})

//showing user works
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

// register user
router.post('/:users', (req, res) => {
	const {username, password, usertype} = req.body
	console.log(req.body)
	mysqlConnection.query('insert into User(username, password, usertype) values (?,?,?);',
	[username, password, usertype], (error, rows, fields) =>{
		if(!error){
			res.json({Status: 'User saved'})
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