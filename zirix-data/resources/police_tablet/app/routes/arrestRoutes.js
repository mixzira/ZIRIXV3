const express = require('express');
const arrestController = require('../controllers/arrestController');

const router = express.Router()

router
    .post('/api/police_tablet/arrest/', arrestController.arrestPlayer)

module.exports = router