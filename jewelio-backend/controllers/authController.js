const { db } = require('../firebase');

// User signup
exports.signup = (req, res) => {
    const { name, email, password, phone, address } = req.body;
    // TODO: Connect with Firebase or DB for real signup
    res.json({ message: 'User signed up successfully', user: { name, email } });
};

// User login
exports.login = async (req, res) => {
    try {
        const { email, password } = req.body;

        if (!email || !password) {
            return res.status(400).json({ error: 'Email and password are required' });
        }

        // Query the admin collection for the provided email
        const adminSnapshot = await db.collection('admin')
            .where('email', '==', email)
            .limit(1)
            .get();

        if (adminSnapshot.empty) {
            return res.status(401).json({ error: 'Invalid credentials' });
        }

        const adminData = adminSnapshot.docs[0].data();

        // Check password (using plain text as per user request for now)
        if (adminData.password !== password) {
            return res.status(401).json({ error: 'Invalid credentials' });
        }

        // Success response
        res.json({
            message: 'Login successful',
            token: 'demo-admin-token-' + Date.now(), // Placeholder token
            admin: {
                id: adminSnapshot.docs[0].id,
                email: adminData.email,
                name: adminData.name,
                role: adminData.role
            }
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
