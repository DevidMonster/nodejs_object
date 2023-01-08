const express = require('express');
const router = express.Router();
const ItemController = require('../app/controllers/itemController');

router.get('/', ItemController.read);
router.post('/', ItemController.create);
router.get('/', ItemController.read);

module.exports = router;
