const express = require('express');
const router = express.Router();
const db = require('../firebase');

// GET all orders
router.get('/', async (req, res) => {
    try {
        const snapshot = await db.collection('orders')
            .limit(20)
            .get();
        const orders = [];

        snapshot.forEach(doc => {
            const data = doc.data();
            orders.push({
                id: doc.id,
                ...data,
                total: data.totalAmount || 0,
                customerName: data.userID || 'Guest',
                createdAt: data.created_at ? new Date(data.created_at._seconds * 1000).toISOString() : ''
            });
        });

        res.json(orders);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// GET single order
router.get('/:id', async (req, res) => {
    try {
        const doc = await db.collection('orders').doc(req.params.id).get();

        if (!doc.exists) {
            return res.status(404).json({ error: 'Order not found' });
        }

        const data = doc.data();
        res.json({
            id: doc.id,
            ...data,
            total: data.totalAmount || 0,
            customerName: data.userID || 'Guest',
            createdAt: data.created_at ? new Date(data.created_at._seconds * 1000).toISOString() : ''
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// PUT update order status
router.put('/:id/status', async (req, res) => {
    try {
        const { status } = req.body;

        if (!status) {
            return res.status(400).json({ error: 'Status is required' });
        }

        await db.collection('orders').doc(req.params.id).update({
            status,
            updatedAt: new Date().toISOString()
        });

        res.json({ id: req.params.id, status });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// GET order statistics
router.get('/stats/summary', async (req, res) => {
    try {
        // Use count() for total orders
        const countSnapshot = await db.collection('orders').count().get();
        const totalOrders = countSnapshot.data().count;

        // For revenue and status breakdown, we scan the last 100 orders
        const snapshot = await db.collection('orders')
            .limit(100)
            .get();

        let totalRevenue = 0;
        const statusCount = {};

        snapshot.forEach(doc => {
            const order = doc.data();
            totalRevenue += order.totalAmount || 0;

            const status = order.status || 'pending';
            statusCount[status] = (statusCount[status] || 0) + 1;
        });

        res.json({
            totalOrders,
            totalRevenue, // Revenue from last 100 orders
            statusCount
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;
