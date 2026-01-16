// Dashboard JavaScript

let dashboardData = null;

// Load dashboard data on page load
document.addEventListener('DOMContentLoaded', async () => {
    await loadDashboardStats();
    await loadRecentOrders();
});

// Load dashboard statistics
async function loadDashboardStats() {
    try {
        // Don't use showLoading for statsContainer as it clears the stat cards
        // Instead, we can add a loading class to the cards or just wait for stats

        const data = await api.get('/dashboard/stats');
        dashboardData = data;

        // Update stat cards
        const productsEl = document.getElementById('totalProducts');
        const ordersEl = document.getElementById('totalOrders');
        const revenueEl = document.getElementById('totalRevenue');
        const customersEl = document.getElementById('totalCustomers');

        if (productsEl) productsEl.textContent = data.totalProducts || 0;
        if (ordersEl) ordersEl.textContent = data.totalOrders || 0;
        if (revenueEl) revenueEl.textContent = formatCurrency(data.totalRevenue || 0);
        if (customersEl) customersEl.textContent = data.totalCustomers || 0;

    } catch (error) {
        console.error('Failed to load dashboard stats:', error);
    }
}

// Load recent orders
async function loadRecentOrders() {
    try {
        if (!dashboardData || !dashboardData.recentOrders) {
            return;
        }

        const tbody = document.getElementById('recentOrdersBody');
        if (!tbody) return;

        tbody.innerHTML = '';

        if (dashboardData.recentOrders.length === 0) {
            tbody.innerHTML = '<tr><td colspan="5" class="text-center">No recent orders</td></tr>';
            return;
        }

        dashboardData.recentOrders.forEach(order => {
            const row = document.createElement('tr');
            row.innerHTML = `
        <td>#${order.id.substring(0, 8)}</td>
        <td>${order.customerName || 'N/A'}</td>
        <td>${formatCurrency(order.total || 0)}</td>
        <td>${getStatusBadge(order.status || 'pending')}</td>
        <td>${formatDate(order.createdAt)}</td>
      `;
            tbody.appendChild(row);
        });

    } catch (error) {
        console.error('Failed to load recent orders:', error);
    }
}

// Refresh dashboard
async function refreshDashboard() {
    await loadDashboardStats();
    await loadRecentOrders();
    showAlert('Dashboard refreshed successfully', 'success');
}
