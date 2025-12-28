const express = require('express');
const router = express.Router();

// User signup
router.post('/signup', (req, res) => {
  const { name, email, password, phone, address } = req.body;
  // TODO: Connect with Firebase or DB for real signup
  res.json({ message: 'User signed up successfully', user: { name, email } });
});

// User login
router.post('/login', (req, res) => {
  const { email, password } = req.body;
  // TODO: Validate user with Firebase or DB
  res.json({ message: 'Login successful', email });
});

module.exports = router;
