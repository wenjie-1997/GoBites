const mysql = require('mysql');

//create connection
const mysqlConnection = mysql.createConnection({
	host: 'localhost',
	user: 'root',
	password: 'void',
	database: 'gobites',
});

//connect to db
mysqlConnection.connect(function(error){
	if(error){
		console.log(error)
		return
	} else{
		console.log('Database is connected')
	}
})

module.exports = mysqlConnection