const express = require('express');
const router = express.Router();
const { getBanner } = require('../app/controllers/banner');

router.get('/', getBanner);

module.exports = router;
