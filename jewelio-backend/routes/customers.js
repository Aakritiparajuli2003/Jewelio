const express = require('express');
const router = express.Router();
const customerController = require('../controllers/customerController');

// GET all customers
router.get('/', customerController.getCustomers);

// GET single customer
router.get('/:id', customerController.getCustomerById);

// GET customer statistics
router.get('/stats/summary', customerController.getCustomerStats);

module.exports = router;
