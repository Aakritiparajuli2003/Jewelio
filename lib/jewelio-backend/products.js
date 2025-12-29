const express = require('express');
const router = express.Router();

// Get all products
router.get('/', (req, res) => {
  // TODO: Fetch products from DB
  res.json([
    { id: 1, name: 'Gold Necklace', price: 250, stock: 10 },
    { id: 2, name: 'Diamond Ring', price: 500, stock: 5 },
    { id: 3, name: 'Silver Bracelet', price: 150, stock: 8 },
  ]);
});

module.exports = router;