const express = require('express');
const router = express.Router();
const orderController = require('../controllers/orderController');

// GET all orders
router.get('/', orderController.getOrders);

// GET single order
router.get('/:id', orderController.getOrderById);

// PUT update order status
router.put('/:id/status', orderController.updateOrderStatus);

// GET order statistics
router.get('/stats/summary', orderController.getOrderStats);

module.exports = router;
