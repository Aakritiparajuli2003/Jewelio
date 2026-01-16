// Authentication JavaScript for Login Page

document.addEventListener('DOMContentLoaded', () => {
    const loginForm = document.getElementById('loginForm');

    if (loginForm) {
        loginForm.addEventListener('submit', handleLogin);
    }
});

async function handleLogin(e) {
    e.preventDefault();

    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    const submitBtn = document.getElementById('submitBtn');

    // Disable button and show loading
    submitBtn.disabled = true;
    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Logging in...';

    try {
        // For demo purposes, accept any email/password
        // In production, this should validate against Firebase Auth
        if (email && password) {
            // Simulate API call delay
            await new Promise(resolve => setTimeout(resolve, 1000));

            // Store a demo token
            const demoToken = btoa(email + ':' + Date.now());
            localStorage.setItem('adminToken', demoToken);
            localStorage.setItem('adminEmail', email);

            // Redirect to dashboard
            window.location.href = 'dashboard.html';
        } else {
            throw new Error('Please enter email and password');
        }
    } catch (error) {
        showError(error.message || 'Login failed. Please try again.');
        submitBtn.disabled = false;
        submitBtn.innerHTML = '<i class="fas fa-sign-in-alt"></i> Login';
    }
}

function showError(message) {
    const errorDiv = document.getElementById('errorMessage');
    if (errorDiv) {
        errorDiv.textContent = message;
        errorDiv.style.display = 'block';

        setTimeout(() => {
            errorDiv.style.display = 'none';
        }, 5000);
    }
}
