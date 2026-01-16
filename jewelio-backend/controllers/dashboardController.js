const { db } = require('../firebase');

// GET dashboard statistics
exports.getStats = async (req, res) => {
    try {
        const productsCountSnapshot = await db.collection('products').count().get();
        const totalProducts = productsCountSnapshot.data().count;

        const ordersCountSnapshot = await db.collection('orders').count().get();
        const totalOrders = ordersCountSnapshot.data().count;

        const usersCountSnapshot = await db.collection('users').count().get();
        const totalCustomers = usersCountSnapshot.data().count;

        // Get revenue and status breakdown
        const ordersSnapshot = await db.collection('orders')
            .limit(100)
            .get();

        let totalRevenue = 0;
        let pendingOrders = 0;
        let shippedOrders = 0;
        let deliveredOrders = 0;

        ordersSnapshot.forEach(doc => {
            const order = doc.data();
            totalRevenue += order.totalAmount || 0;

            const status = (order.status || 'pending').toLowerCase();
            if (status === 'pending') pendingOrders++;
            else if (status === 'shipped') shippedOrders++;
            else if (status === 'delivered') deliveredOrders++;
        });

        // Get recent orders (last 5)
        const recentOrdersSnapshot = await db.collection('orders')
            .limit(5)
            .get();

        const recentOrders = [];
        recentOrdersSnapshot.forEach(doc => {
            const data = doc.data();
            recentOrders.push({
                id: doc.id,
                ...data,
                total: data.totalAmount || 0,
                customerName: data.userID || 'Guest',
                createdAt: data.created_at ? new Date(data.created_at._seconds * 1000).toISOString() : ''
            });
        });

        const stats = {
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
        };

        res.json(stats);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
