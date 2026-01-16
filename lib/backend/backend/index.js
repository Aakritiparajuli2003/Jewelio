const express = require('express');
const cors = require('cors');

const authRoutes = require('./routes/auth');
const productsRoutes = require('./routes/products');
const ordersRoutes = require('./routes/orders');
const couponsRoutes = require('./routes/coupons');

const app = express();
app.use(cors());
app.use(express.json());

// Routes
app.use('/auth', authRoutes);
app.use('/products', productsRoutes);
app.use('/orders', ordersRoutes);
app.use('/coupons', couponsRoutes);

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Jewelio backend running on http://localhost:${PORT}`);
});
