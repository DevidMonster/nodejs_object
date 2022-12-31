const express = require('express');
const app = express();
const router = express.Router();

const homeController = require('../app/controllers/homeController');

router.get('/', homeController.index);

module.exports = router;
