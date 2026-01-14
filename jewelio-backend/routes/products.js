const express = require('express');
const router = express.Router();
const db = require('../firebase');

// GET all products
router.get('/', async (req, res) => {
    try {
        const snapshot = await db.collection('products').get();
        const products = [];

        snapshot.forEach(doc => {
            products.push({ id: doc.id, ...doc.data() });
        });

        res.json(products);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// GET single product
router.get('/:id', async (req, res) => {
    try {
        const doc = await db.collection('products').doc(req.params.id).get();

        if (!doc.exists) {
            return res.status(404).json({ error: 'Product not found' });
        }

        res.json({ id: doc.id, ...doc.data() });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// POST new product
router.post('/', async (req, res) => {
    try {
        const { name, price, category, description, image, stock } = req.body;

        if (!name || !price) {
            return res.status(400).json({ error: 'Name and price are required' });
        }

        const productData = {
            name,
            price: parseFloat(price),
            category: category || 'Uncategorized',
            description: description || '',
            image: image || '',
            stock: parseInt(stock) || 0,
            createdAt: new Date().toISOString()
        };

        const docRef = await db.collection('products').add(productData);

        res.status(201).json({ id: docRef.id, ...productData });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// PUT update product
router.put('/:id', async (req, res) => {
    try {
        const { name, price, category, description, image, stock } = req.body;

        const updateData = {
            ...(name && { name }),
            ...(price && { price: parseFloat(price) }),
            ...(category && { category }),
            ...(description !== undefined && { description }),
            ...(image !== undefined && { image }),
            ...(stock !== undefined && { stock: parseInt(stock) }),
            updatedAt: new Date().toISOString()
        };

        await db.collection('products').doc(req.params.id).update(updateData);

        res.json({ id: req.params.id, ...updateData });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// DELETE product
router.delete('/:id', async (req, res) => {
    try {
        await db.collection('products').doc(req.params.id).delete();
        res.json({ message: 'Product deleted successfully' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;
