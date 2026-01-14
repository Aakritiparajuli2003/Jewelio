const express = require('express');
const router = express.Router();
const db = require('../firebase');

// GET all customers
router.get('/', async (req, res) => {
    try {
        const snapshot = await db.collection('customers').get();
        const customers = [];

        snapshot.forEach(doc => {
            customers.push({ id: doc.id, ...doc.data() });
        });

        res.json(customers);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// GET single customer
router.get('/:id', async (req, res) => {
    try {
        const doc = await db.collection('customers').doc(req.params.id).get();

        if (!doc.exists) {
            return res.status(404).json({ error: 'Customer not found' });
        }

        res.json({ id: doc.id, ...doc.data() });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// GET customer statistics
router.get('/stats/summary', async (req, res) => {
    try {
        const snapshot = await db.collection('customers').get();
        const totalCustomers = snapshot.size;

        res.json({
            totalCustomers
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;
