const express = require('express');
const router = express.Router();
const { getUserById, getUser } = require('../app/controllers/general');

router.get('/user', getUser);
router.get('/user/:id', getUserById);

module.exports = router;
