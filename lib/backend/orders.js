const express = require('express');
const router = express.Router();

// Create an order
router.post('/create', (req, res) => {
  const { customerName, productId, quantity, totalPrice } = req.body;
  // TODO: Save order to DB
  res.json({
    message: 'Order created successfully',
    order: { customerName, productId, quantity, totalPrice, status: 'Pending' }
  });
});

module.exports = router;