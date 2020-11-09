const { Router } = require('express')
const router = Router();

const mysqlConnection = require('../database/database')

//works
router.get('/', (req,res) => {
	res.status(200).json('Server on port 8000 and database is connected')
})

//showing user works
router.get('/:users', (req,res) => {
	mysqlConnection.query('select * from user;', (error, rows, fields) => {
		if(!error){
			res.json(rows)
		} else{
			console.log(error)
		}
	})
})

//showing user by id works
router.get('/:users/:id', (req,res) => {
	const {id} = req.params;
	mysqlConnection.query('select * from user where id = ?;', [id], (error, rows, fields) => {
		if(!error){
			res.json(rows)
		} else {
			console.log(error)
		}
	})
})

//adding values doesnt work!!
router.post('/:users', (req, res) => {
	const {id, username, name, lastname, mail, randomstr, hash} = req.body;
	console.log(req.body);
	mysqlConnection.query('insert into user(id, username, name, lastname, mail, randomstr, hash) values (?, ?, ?, ?, ?, ?, ?)',
	[id, username, name, lastname, mail, randomstr, hash], (error, rows, fields) =>{
		if(!error){
			res.json({Status: 'User saved'})
		} else{
			console.log(error)
		}
	})
})

router.put('/:users/:id', (req, res) => {
	const {id, username, name, lastname, mail, randomstr, hash} = req.body
	console.log(req.body)
	mysqlConnection.query('update user set username = ?, name = ?, lastname =?, mail = ?, randomstr = ?, hash = ?, where id = ?;',
	[username, name, lastname, mail, randomstr, hash, id], (error, rows, fields) => {
		if(!error){
			res.json({Status: 'User updated'})
		} else {
			console.log(error)
		}
	})
})

//works well
router.delete('/:users/:id', (req, res) => {
	const {id} = req.params;
	mysqlConnection.query('delete from user where id =?', [id], (error, rows, fields) => {
		if(!error){
			res.json({Status: 'User deleted'})
		} else{
			res.json({Status: error})
		}
	})
})

module.exports = router