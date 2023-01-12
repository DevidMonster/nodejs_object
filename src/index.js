const path = require('path');
const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
const { engine } = require('express-handlebars');
const bodyParser = require('body-parser');
const mysql = require('mysql2');
const app = express();
require('dotenv').config();

const port = process.env.PORT || 3000;
const connection = require('./config/db');
app.use(cors());

// database init
function mysqlConnect() {
    global.connection = mysql.createConnection(connection);

    global.connection.connect(function (err) {
        if (err) {
            console.log('error when connecting to db');
            setTimeout(mysqlConnect, 2000);
        }
        console.log('connected to database');
    });
    global.connection.on('error', function (err) {
        if (err.code === 'PROTOCOL_CONNECTION_LOST') {
            mysqlConnect();
        } else {
            throw err;
        }
    });
}

mysqlConnect();

//Use static folder
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

//HTTP logger
app.use(morgan('combined'));

//Template engine
app.engine(
    'hbs',
    engine({
        extname: '.hbs',
    }),
);
app.set('view engine', 'hbs');
app.set('views', path.join(__dirname, 'resources', 'views'));

app.use(function (req, res, next) {
    res.header('Access-Control-Allow-Origin', '*');
    res.header(
        'Access-Control-Allow-Headers',
        'Origin, X-Requested-With, Content-Type, Accept',
    );
    next();
});

//Routes
const itemRoutes = require('./routes/Item');

app.use('/item', itemRoutes);

app.listen(port, () => {
    console.log(`Bạn đang chạy ở cổng: http://localhost:${port}`);
});
