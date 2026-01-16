// Customers Management JavaScript

let customers = [];

// Load customers on page load
document.addEventListener('DOMContentLoaded', async () => {
    await loadCustomers();
    setupEventListeners();
});

// Setup event listeners
function setupEventListeners() {
    const searchInput = document.getElementById('searchInput');
    if (searchInput) {
        searchInput.addEventListener('input', searchCustomers);
    }
}

// Load all customers
async function loadCustomers() {
    try {
        showLoading('customersTableBody');

        customers = await api.get('/customers');
        displayCustomers(customers);

    } catch (error) {
        console.error('Failed to load customers:', error);
        document.getElementById('customersTableBody').innerHTML =
            '<tr><td colspan="5" class="text-center">Failed to load customers</td></tr>';
    }
}

// Display customers in table
function displayCustomers(customersToDisplay) {
    const tbody = document.getElementById('customersTableBody');
    if (!tbody) return;

    tbody.innerHTML = '';

    if (customersToDisplay.length === 0) {
        tbody.innerHTML = '<tr><td colspan="5" class="text-center">No customers found</td></tr>';
        return;
    }

    customersToDisplay.forEach(customer => {
        const row = document.createElement('tr');
        row.innerHTML = `
      <td>${customer.name || 'N/A'}</td>
      <td>${customer.email || 'N/A'}</td>
      <td>${customer.phone || 'N/A'}</td>
      <td>${formatDate(customer.createdAt || customer.joinedDate)}</td>
      <td>
        <button class="btn btn-secondary btn-sm" onclick="viewCustomerDetails('${customer.id}')">
          <i class="fas fa-eye"></i> View
        </button>
      </td>
    `;
        tbody.appendChild(row);
    });
}

// View customer details
function viewCustomerDetails(customerId) {
    const customer = customers.find(c => c.id === customerId);
    if (!customer) return;

    const detailsHtml = `
    <div class="customer-details">
      <p><strong>Name:</strong> ${customer.name || 'N/A'}</p>
      <p><strong>Email:</strong> ${customer.email || 'N/A'}</p>
      <p><strong>Phone:</strong> ${customer.phone || 'N/A'}</p>
      <p><strong>Address:</strong> ${customer.address || 'N/A'}</p>
      <p><strong>Joined:</strong> ${formatDate(customer.createdAt || customer.joinedDate)}</p>
      <p><strong>Total Orders:</strong> ${customer.totalOrders || 0}</p>
      <p><strong>Total Spent:</strong> ${formatCurrency(customer.totalSpent || 0)}</p>
    </div>
  `;

    document.getElementById('customerDetailsContent').innerHTML = detailsHtml;
    openModal('customerDetailsModal');
}

// Search customers
function searchCustomers() {
    const searchTerm = document.getElementById('searchInput').value.toLowerCase();

    const filtered = customers.filter(customer =>
        (customer.name || '').toLowerCase().includes(searchTerm) ||
        (customer.email || '').toLowerCase().includes(searchTerm) ||
        (customer.phone || '').toLowerCase().includes(searchTerm)
    );

    displayCustomers(filtered);
}

// Make functions globally available
window.viewCustomerDetails = viewCustomerDetails;
