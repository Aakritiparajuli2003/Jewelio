// Products Management JavaScript

let products = [];
let editingProductId = null;

// Load products on page load
document.addEventListener('DOMContentLoaded', async () => {
    await loadProducts();
    setupEventListeners();
});

// Setup event listeners
function setupEventListeners() {
    const addBtn = document.getElementById('addProductBtn');
    if (addBtn) {
        addBtn.addEventListener('click', () => openAddProductModal());
    }

    const productForm = document.getElementById('productForm');
    if (productForm) {
        productForm.addEventListener('submit', handleProductSubmit);
    }
}

// Load all products
async function loadProducts() {
    try {
        showLoading('productsTableBody');

        products = await api.get('/products');
        displayProducts();

    } catch (error) {
        console.error('Failed to load products:', error);
        document.getElementById('productsTableBody').innerHTML =
            '<tr><td colspan="7" class="text-center">Failed to load products</td></tr>';
    }
}

// Display products in table
function displayProducts() {
    const tbody = document.getElementById('productsTableBody');
    if (!tbody) return;

    tbody.innerHTML = '';

    if (products.length === 0) {
        tbody.innerHTML = '<tr><td colspan="7" class="text-center">No products found</td></tr>';
        return;
    }

    products.forEach(product => {
        const row = document.createElement('tr');
        row.innerHTML = `
      <td>
        ${product.image ?
                `<img src="${product.image}" alt="${product.name}" style="width: 50px; height: 50px; object-fit: cover; border-radius: 8px;">` :
                '<div style="width: 50px; height: 50px; background: var(--dark-hover); border-radius: 8px; display: flex; align-items: center; justify-content: center;"><i class="fas fa-image"></i></div>'
            }
      </td>
      <td>${product.name || 'N/A'}</td>
      <td>${product.category || 'Uncategorized'}</td>
      <td>${formatCurrency(product.price || 0)}</td>
      <td>${product.stock || 0}</td>
      <td>${formatDate(product.createdAt)}</td>
      <td>
        <button class="btn btn-secondary btn-sm" onclick="editProduct('${product.id}')">
          <i class="fas fa-edit"></i> Edit
        </button>
        <button class="btn btn-danger btn-sm" onclick="deleteProduct('${product.id}')">
          <i class="fas fa-trash"></i> Delete
        </button>
      </td>
    `;
        tbody.appendChild(row);
    });
}

// Open add product modal
function openAddProductModal() {
    editingProductId = null;
    document.getElementById('modalTitle').textContent = 'Add New Product';
    document.getElementById('productForm').reset();
    openModal('productModal');
}

// Edit product
function editProduct(productId) {
    const product = products.find(p => p.id === productId);
    if (!product) return;

    editingProductId = productId;
    document.getElementById('modalTitle').textContent = 'Edit Product';

    document.getElementById('productName').value = product.name || '';
    document.getElementById('productCategory').value = product.category || '';
    document.getElementById('productPrice').value = product.price || '';
    document.getElementById('productStock').value = product.stock || '';
    document.getElementById('productDescription').value = product.description || '';
    document.getElementById('productImage').value = product.image || '';

    openModal('productModal');
}

// Handle product form submit
async function handleProductSubmit(e) {
    e.preventDefault();

    const formData = {
        name: document.getElementById('productName').value,
        category: document.getElementById('productCategory').value,
        price: parseFloat(document.getElementById('productPrice').value),
        stock: parseInt(document.getElementById('productStock').value),
        description: document.getElementById('productDescription').value,
        image: document.getElementById('productImage').value
    };

    try {
        if (editingProductId) {
            // Update existing product
            await api.put(`/products/${editingProductId}`, formData);
            showAlert('Product updated successfully', 'success');
        } else {
            // Add new product
            await api.post('/products', formData);
            showAlert('Product added successfully', 'success');
        }

        closeModal('productModal');
        await loadProducts();

    } catch (error) {
        console.error('Failed to save product:', error);
    }
}

// Delete product
async function deleteProduct(productId) {
    if (!confirmAction('Are you sure you want to delete this product?')) {
        return;
    }

    try {
        await api.delete(`/products/${productId}`);
        showAlert('Product deleted successfully', 'success');
        await loadProducts();
    } catch (error) {
        console.error('Failed to delete product:', error);
    }
}

// Search products
function searchProducts() {
    const searchTerm = document.getElementById('searchInput').value.toLowerCase();

    const filteredProducts = products.filter(product =>
        product.name.toLowerCase().includes(searchTerm) ||
        product.category.toLowerCase().includes(searchTerm)
    );

    const tbody = document.getElementById('productsTableBody');
    tbody.innerHTML = '';

    if (filteredProducts.length === 0) {
        tbody.innerHTML = '<tr><td colspan="7" class="text-center">No products found</td></tr>';
        return;
    }

    filteredProducts.forEach(product => {
        const row = document.createElement('tr');
        row.innerHTML = `
      <td>
        ${product.image ?
                `<img src="${product.image}" alt="${product.name}" style="width: 50px; height: 50px; object-fit: cover; border-radius: 8px;">` :
                '<div style="width: 50px; height: 50px; background: var(--dark-hover); border-radius: 8px;"></div>'
            }
      </td>
      <td>${product.name || 'N/A'}</td>
      <td>${product.category || 'Uncategorized'}</td>
      <td>${formatCurrency(product.price || 0)}</td>
      <td>${product.stock || 0}</td>
      <td>${formatDate(product.createdAt)}</td>
      <td>
        <button class="btn btn-secondary btn-sm" onclick="editProduct('${product.id}')">
          <i class="fas fa-edit"></i> Edit
        </button>
        <button class="btn btn-danger btn-sm" onclick="deleteProduct('${product.id}')">
          <i class="fas fa-trash"></i> Delete
        </button>
      </td>
    `;
        tbody.appendChild(row);
    });
}

// Make functions globally available
window.editProduct = editProduct;
window.deleteProduct = deleteProduct;
window.searchProducts = searchProducts;
