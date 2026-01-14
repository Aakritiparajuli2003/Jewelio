const express = require('express');
const router = express.Router();
const db = require('../firebase');

// GET all orders
router.get('/', async (req, res) => {
    try {
        const snapshot = await db.collection('orders').orderBy('createdAt', 'desc').get();
        const orders = [];

        snapshot.forEach(doc => {
            orders.push({ id: doc.id, ...doc.data() });
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

        res.json({ id: doc.id, ...doc.data() });
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
        const snapshot = await db.collection('orders').get();
        let totalOrders = 0;
        let totalRevenue = 0;
        const statusCount = {};

        snapshot.forEach(doc => {
            const order = doc.data();
            totalOrders++;
            totalRevenue += order.total || 0;

            const status = order.status || 'pending';
            statusCount[status] = (statusCount[status] || 0) + 1;
        });

        res.json({
            totalOrders,
            totalRevenue,
            statusCount
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;
