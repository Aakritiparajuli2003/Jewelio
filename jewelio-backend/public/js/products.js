// Products Management JavaScript

let products = [];
let editingProductId = null;

// Load products on page load
document.addEventListener('DOMContentLoaded', async () => {
    setupEventListeners();
    await loadProducts();
});

// Setup event listeners
function setupEventListeners() {

    const addBtn = document.getElementById('addProductBtn');
    if (addBtn) {
        addBtn.addEventListener('click', openAddProductModal);
    }

    const productForm = document.getElementById('productForm');
    if (productForm) {
        productForm.addEventListener('submit', handleProductSubmit);
    }
}

// Load products
async function loadProducts() {

    try {

        showLoading('productsTableBody');

        products = await api.get('/products');

        console.log("PRODUCTS LOADED:", products); // DEBUG

        displayProducts();

    } catch (error) {

        console.error("LOAD PRODUCTS ERROR:", error);

        document.getElementById('productsTableBody').innerHTML =
            '<tr><td colspan="8" class="text-center">Failed to load products</td></tr>';
    }
}

// Display products
function displayProducts() {

    const tbody = document.getElementById('productsTableBody');
    if (!tbody) return;

    tbody.innerHTML = '';

    if (!products || products.length === 0) {

        tbody.innerHTML =
            '<tr><td colspan="8" class="text-center">No products found</td></tr>';

        return;
    }

    products.forEach(product => {

        const badgeHTML = `
            ${product.is_new ? '<span class="badge">NEW</span>' : ''}
            ${product.is_best_seller ? '<span class="badge">BEST</span>' : ''}
            ${product.is_gifting ? '<span class="badge">GIFT</span>' : ''}
        `;

        const row = document.createElement('tr');

        row.innerHTML = `
          <td>
            ${product.image
                ? `<img src="${product.image}" style="width:50px;height:50px;border-radius:8px;object-fit:cover;">`
                : `<div style="width:50px;height:50px;background:#ddd;border-radius:8px;"></div>`
            }
          </td>

          <td>${product.name || 'N/A'}</td>
          <td>${product.category || 'Uncategorized'}</td>
          <td>${formatCurrency(product.price || 0)}</td>
          <td>${product.stock || 0}</td>
          <td>${badgeHTML}</td>
          <td>${formatDate(product.updated_at)}</td>

          <td>
            <button class="btn btn-secondary btn-sm" onclick="editProduct('${product.id}')">
              Edit
            </button>

            <button class="btn btn-danger btn-sm" onclick="deleteProduct('${product.id}')">
              Delete
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

    // Reset flags safely
    if (document.getElementById('isNew')) document.getElementById('isNew').checked = false;
    if (document.getElementById('isBestSeller')) document.getElementById('isBestSeller').checked = false;
    if (document.getElementById('isGifting')) document.getElementById('isGifting').checked = false;

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

    // Load flags safely
    if (document.getElementById('isNew')) document.getElementById('isNew').checked = product.is_new || false;
    if (document.getElementById('isBestSeller')) document.getElementById('isBestSeller').checked = product.is_best_seller || false;
    if (document.getElementById('isGifting')) document.getElementById('isGifting').checked = product.is_gifting || false;

    openModal('productModal');
}

// Submit product form (FIXED)
async function handleProductSubmit(e) {
    e.preventDefault();
    
    // 1. Get the tags from the dropdown (Corrected lookup)
    const tagDropdown = document.getElementById('productTags');
    const selectedTags = tagDropdown ? Array.from(tagDropdown.selectedOptions).map(option => option.value) : [];



    const formData = {

        name: document.getElementById('productName').value.trim(),
        category: document.getElementById('productCategory').value.trim(),
        tags: selectedTags,
        price: Number(document.getElementById('productPrice').value) || 0,
        stock: Number(document.getElementById('productStock').value) || 0,
        description: document.getElementById('productDescription').value.trim(),
        image: document.getElementById('productImage').value.trim(),
      
        // Flags safe
        is_new: document.getElementById('isNew')?.checked || false,
        is_best_seller: document.getElementById('isBestSeller')?.checked || false,
        is_gifting: document.getElementById('isGifting')?.checked || false,

        updated_at: new Date()
    };


    console.log("SENDING PRODUCT DATA:", formData); // DEBUG

    try {

        if (editingProductId) {

            await api.put(`/products/${editingProductId}`, formData);
            showAlert('Product Updated Successfully', 'success');

        } else {

            await api.post('/products', formData);
            showAlert('Product Added Successfully', 'success');
        }

        closeModal('productModal');
        await loadProducts();

    } catch (error) {

        console.error("SAVE PRODUCT ERROR:", error.response || error);
        alert("Product save failed. Check console!");
    }
}

// Delete product
async function deleteProduct(productId) {

    if (!confirmAction('Delete this product?')) return;

    try {

        await api.delete(`/products/${productId}`);
        showAlert('Product Deleted Successfully', 'success');
        await loadProducts();

    } catch (error) {

        console.error("DELETE ERROR:", error);
        alert("Delete failed!");
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

        tbody.innerHTML =
            '<tr><td colspan="8" class="text-center">No products found</td></tr>';

        return;
    }

    filteredProducts.forEach(product => {

        const row = document.createElement('tr');

        row.innerHTML = `
          <td>${product.name}</td>
          <td>${product.category}</td>
          <td>${formatCurrency(product.price)}</td>
          <td>${product.stock}</td>
        `;

        tbody.appendChild(row);
    });
}

// Global access
window.editProduct = editProduct;
window.deleteProduct = deleteProduct;
window.searchProducts = searchProducts;
