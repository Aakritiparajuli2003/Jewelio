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
        showLoading('statsContainer');

        const data = await api.get('/dashboard/stats');
        dashboardData = data;

        // Update stat cards
        document.getElementById('totalProducts').textContent = data.totalProducts || 0;
        document.getElementById('totalOrders').textContent = data.totalOrders || 0;
        document.getElementById('totalRevenue').textContent = formatCurrency(data.totalRevenue || 0);
        document.getElementById('totalCustomers').textContent = data.totalCustomers || 0;

        // Remove loading spinner
        const spinner = document.querySelector('.spinner');
        if (spinner) spinner.remove();

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
