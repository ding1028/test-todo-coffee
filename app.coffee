
express = require('express')
routes = require('./routes')

bodyParser = require('body-parser'); 
methodOverride = require('method-override');
errorHandler = require('errorhandler');

app = module.exports = express();

# Configuration
app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'
app.set 'view options', { pretty: true }
  
app.use bodyParser()
app.use methodOverride()
app.use require('stylus').middleware { src: __dirname + '/public' }
app.use express.static(__dirname + '/public')

app.use errorHandler { dumpExceptions: true, showStack: true }

# Routes
app.get '/', routes.index

port = process.env.PORT || 3000
app.listen port, ->
  console.log("Listening on " + port)

