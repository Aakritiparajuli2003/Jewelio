// Orders Management JavaScript

let orders = [];

// Load orders on page load
document.addEventListener('DOMContentLoaded', async () => {
    await loadOrders();
    setupEventListeners();
});

// Setup event listeners
function setupEventListeners() {
    const filterSelect = document.getElementById('statusFilter');
    if (filterSelect) {
        filterSelect.addEventListener('change', filterOrders);
    }
}

// Load all orders
async function loadOrders() {
    try {
        showLoading('ordersTableBody');

        orders = await api.get('/orders');
        displayOrders(orders);

    } catch (error) {
        console.error('Failed to load orders:', error);
        document.getElementById('ordersTableBody').innerHTML =
            '<tr><td colspan="6" class="text-center">Failed to load orders</td></tr>';
    }
}

// Display orders in table
function displayOrders(ordersToDisplay) {
    const tbody = document.getElementById('ordersTableBody');
    if (!tbody) return;

    tbody.innerHTML = '';

    if (ordersToDisplay.length === 0) {
        tbody.innerHTML = '<tr><td colspan="6" class="text-center">No orders found</td></tr>';
        return;
    }

    ordersToDisplay.forEach(order => {
        const row = document.createElement('tr');
        row.innerHTML = `
      <td>#${order.id.substring(0, 8)}</td>
      <td>${order.customerName || 'N/A'}</td>
      <td>${order.customerEmail || 'N/A'}</td>
      <td>${formatCurrency(order.total || 0)}</td>
      <td>${getStatusBadge(order.status || 'pending')}</td>
      <td>
        <select class="form-select" onchange="updateOrderStatus('${order.id}', this.value)" style="width: auto; display: inline-block; padding: 0.25rem 0.5rem;">
          <option value="pending" ${order.status === 'pending' ? 'selected' : ''}>Pending</option>
          <option value="processing" ${order.status === 'processing' ? 'selected' : ''}>Processing</option>
          <option value="shipped" ${order.status === 'shipped' ? 'selected' : ''}>Shipped</option>
          <option value="delivered" ${order.status === 'delivered' ? 'selected' : ''}>Delivered</option>
          <option value="cancelled" ${order.status === 'cancelled' ? 'selected' : ''}>Cancelled</option>
        </select>
        <button class="btn btn-secondary btn-sm" onclick="viewOrderDetails('${order.id}')">
          <i class="fas fa-eye"></i> View
        </button>
      </td>
    `;
        tbody.appendChild(row);
    });
}

// Update order status
async function updateOrderStatus(orderId, newStatus) {
    try {
        await api.put(`/orders/${orderId}/status`, { status: newStatus });
        showAlert('Order status updated successfully', 'success');
        await loadOrders();
    } catch (error) {
        console.error('Failed to update order status:', error);
    }
}

// View order details
function viewOrderDetails(orderId) {
    const order = orders.find(o => o.id === orderId);
    if (!order) return;

    const detailsHtml = `
    <div class="order-details">
      <p><strong>Order ID:</strong> #${order.id}</p>
      <p><strong>Customer:</strong> ${order.customerName || 'N/A'}</p>
      <p><strong>Email:</strong> ${order.customerEmail || 'N/A'}</p>
      <p><strong>Phone:</strong> ${order.customerPhone || 'N/A'}</p>
      <p><strong>Address:</strong> ${order.shippingAddress || 'N/A'}</p>
      <p><strong>Total:</strong> ${formatCurrency(order.total || 0)}</p>
      <p><strong>Status:</strong> ${getStatusBadge(order.status || 'pending')}</p>
      <p><strong>Order Date:</strong> ${formatDateTime(order.createdAt)}</p>
      ${order.items ? `
        <h4 style="margin-top: 1rem; margin-bottom: 0.5rem;">Order Items:</h4>
        <ul style="list-style: none; padding: 0;">
          ${order.items.map(item => `
            <li style="padding: 0.5rem; background: var(--dark-hover); margin-bottom: 0.5rem; border-radius: 6px;">
              ${item.name} - Qty: ${item.quantity} - ${formatCurrency(item.price)}
            </li>
          `).join('')}
        </ul>
      ` : ''}
    </div>
  `;

    document.getElementById('orderDetailsContent').innerHTML = detailsHtml;
    openModal('orderDetailsModal');
}

// Filter orders by status
function filterOrders() {
    const filterValue = document.getElementById('statusFilter').value;

    if (filterValue === 'all') {
        displayOrders(orders);
    } else {
        const filtered = orders.filter(order =>
            (order.status || 'pending').toLowerCase() === filterValue.toLowerCase()
        );
        displayOrders(filtered);
    }
}

// Make functions globally available
window.updateOrderStatus = updateOrderStatus;
window.viewOrderDetails = viewOrderDetails;
