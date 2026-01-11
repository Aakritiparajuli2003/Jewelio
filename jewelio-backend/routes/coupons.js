const express = require('express');
const router = express.Router();

// Get all coupons
router.get('/', (req, res) => {
  // TODO: Fetch coupons from DB
  res.json([
    { code: 'WELCOME10', discount: 10 },
    { code: 'JEWEL20', discount: 20 }
  ]);
});

module.exports = router;
