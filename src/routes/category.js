const express = require('express');
const router = express.Router();
const { getCategory } = require('../app/controllers/category');

router.get('/', getCategory);

module.exports = router;
