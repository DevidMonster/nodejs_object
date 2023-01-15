const express = require('express');
const router = express.Router();
const { getItem } = require('../app/controllers/itemController');

router.get('/', getItem);
router.post('/', );

module.exports = router;
