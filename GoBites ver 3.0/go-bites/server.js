const serveStatic = require('serve-static');
const history = require('connect-history-api-fallback');
const enforce = require('express-sslify');
const express = require('express');
const cors = require("cors");

const app = express();

app.use(cors());
app.use(enforce.HTTPS({ trustProtoHeader: true}));
app.use(serveStatic(__dirname + '/dist'));
app.use(history());

// set port, listen for requests
const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
});