const { db, admin } = require('../firebase');

// GET all products
exports.getProducts = async (req, res) => {
    try {
        const snapshot = await db.collection('products').limit(20).get();
        const products = [];

        snapshot.forEach(doc => {
            const data = doc.data();
            products.push({
                id: doc.id,
                ...data,
                image: data.image_url || '',
                category: data.category_id || '',
                createdAt: data.created_at ? new Date(data.created_at._seconds * 1000).toISOString() : ''
            });
        });

        res.json(products);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

// GET single product
exports.getProductById = async (req, res) => {
    try {
        const doc = await db.collection('products').doc(req.params.id).get();

        if (!doc.exists) {
            return res.status(404).json({ error: 'Product not found' });
        }

        const data = doc.data();
        res.json({
            id: doc.id,
            ...data,
            image: data.image_url || '',
            category: data.category_id || '',
            createdAt: data.created_at ? new Date(data.created_at._seconds * 1000).toISOString() : ''
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

// POST new product
exports.createProduct = async (req, res) => {
    try {
        const { name, price, category, description, image, stock } = req.body;

        if (!name || !price) {
            return res.status(400).json({ error: 'Name and price are required' });
        }

        const productData = {
            name,
            price: parseFloat(price),
            category_id: category || 'Uncategorized',
            description: description || '',
            image_url: image || '',
            stock: parseInt(stock) || 0,
            created_at: admin.firestore.FieldValue.serverTimestamp()
        };

        const docRef = await db.collection('products').add(productData);

        res.status(201).json({ id: docRef.id, ...productData });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

// PUT update product
exports.updateProduct = async (req, res) => {
    try {
        const { name, price, category, description, image, stock } = req.body;

        const updateData = {
            ...(name && { name }),
            ...(price && { price: parseFloat(price) }),
            ...(category && { category_id: category }),
            ...(description !== undefined && { description }),
            ...(image !== undefined && { image_url: image }),
            ...(stock !== undefined && { stock: parseInt(stock) }),
            updated_at: admin.firestore.FieldValue.serverTimestamp()
        };

        await db.collection('products').doc(req.params.id).update(updateData);

        res.json({ id: req.params.id, ...updateData });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

// DELETE product
exports.deleteProduct = async (req, res) => {
    try {
        await db.collection('products').doc(req.params.id).delete();
        res.json({ message: 'Product deleted successfully' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
