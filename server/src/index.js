const express = require('express')
const bodyParser = require('body-parser')

const app = express();
app.use(bodyParser.json())

//Settings
app.set('port', process.env.PORT || 8000)

//Middlewares
app.use(express.json())

//Routes
app.use(require('./routes/user'))

//Starting the server
app.listen(app.get('port'), () => {
	console.log('Server on port', app.get('port'))
})