require('dotenv').config();
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const path = require("path");

const app = express();

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Serve static files (CSS, JS, images)
app.use('/public', express.static(path.join(__dirname, 'public')));

// Serve views (HTML files)
app.use('/views', express.static(path.join(__dirname, 'views')));

// Import routes
const authRoutes = require('./routes/auth');
const productsRoutes = require('./routes/products');
const ordersRoutes = require('./routes/orders');
const customersRoutes = require('./routes/customers');
const dashboardRoutes = require('./routes/dashboard');

// API Routes
app.use('/api/auth', authRoutes);
app.use('/api/products', productsRoutes);
app.use('/api/orders', ordersRoutes);
app.use('/api/customers', customersRoutes);
app.use('/api/dashboard', dashboardRoutes);


// Root route - redirect to login
app.get("/", (req, res) => {
  res.redirect('/views/login.html');
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`✅ Jewelio Admin Dashboard Server running on http://localhost:${PORT}`);
  console.log(`📊 Dashboard: http://localhost:${PORT}/views/dashboard.html`);
  console.log(`🔐 Login: http://localhost:${PORT}/views/login.html`);
});
