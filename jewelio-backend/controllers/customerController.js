const { db } = require('../firebase');

// GET all customers
exports.getCustomers = async (req, res) => {
    try {
        const snapshot = await db.collection('users').limit(20).get();
        const customers = [];

        snapshot.forEach(doc => {
            customers.push({ id: doc.id, ...doc.data() });
        });

        res.json(customers);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

// GET single customer
exports.getCustomerById = async (req, res) => {
    try {
        const doc = await db.collection('users').doc(req.params.id).get();

        if (!doc.exists) {
            return res.status(404).json({ error: 'Customer not found' });
        }

        res.json({ id: doc.id, ...doc.data() });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

// GET customer statistics
exports.getCustomerStats = async (req, res) => {
    try {
        const snapshot = await db.collection('users').count().get();
        const totalCustomers = snapshot.data().count;

        res.json({
            totalCustomers
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
