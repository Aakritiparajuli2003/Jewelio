const express = require('express');
const router = express.Router();
const db = require('../firebase');

// GET dashboard statistics
router.get('/stats', async (req, res) => {
    try {
        // Get products count
        const productsSnapshot = await db.collection('products').get();
        const totalProducts = productsSnapshot.size;

        // Get orders data
        const ordersSnapshot = await db.collection('orders').get();
        let totalOrders = 0;
        let totalRevenue = 0;
        let pendingOrders = 0;
        let shippedOrders = 0;
        let deliveredOrders = 0;

        ordersSnapshot.forEach(doc => {
            const order = doc.data();
            totalOrders++;
            totalRevenue += order.total || 0;

            const status = (order.status || 'pending').toLowerCase();
            if (status === 'pending') pendingOrders++;
            else if (status === 'shipped') shippedOrders++;
            else if (status === 'delivered') deliveredOrders++;
        });

        // Get customers count
        const customersSnapshot = await db.collection('customers').get();
        const totalCustomers = customersSnapshot.size;

        // Get recent orders (last 5)
        const recentOrdersSnapshot = await db.collection('orders')
            .orderBy('createdAt', 'desc')
            .limit(5)
            .get();

        const recentOrders = [];
        recentOrdersSnapshot.forEach(doc => {
            recentOrders.push({ id: doc.id, ...doc.data() });
        });

        res.json({
            totalProducts,
            totalOrders,
            totalRevenue,
            totalCustomers,
            ordersByStatus: {
                pending: pendingOrders,
                shipped: shippedOrders,
                delivered: deliveredOrders
            },
            recentOrders
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;
