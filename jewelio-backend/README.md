# Jewelio Admin Dashboard

A modern, full-featured admin dashboard for managing the Jewelio jewelry e-commerce platform. Built with Node.js, Express, Firebase, and vanilla HTML/CSS/JavaScript.

## Features

✨ **Modern UI/UX**
- Premium dark theme with gold accents
- Fully responsive design
- Smooth animations and transitions
- Intuitive navigation

📊 **Dashboard Analytics**
- Real-time statistics
- Total products, orders, revenue, and customers
- Recent orders overview

💎 **Product Management**
- Complete CRUD operations
- Product categorization
- Stock management
- Image support
- Search functionality

🛒 **Order Management**
- View all orders
- Update order status
- Filter by status
- Order details view

👥 **Customer Management**
- Customer list with search
- Customer details
- Order history

⚙️ **Settings**
- Profile management
- Store configuration
- Password change

## Tech Stack

**Backend:**
- Node.js
- Express.js
- Firebase Admin SDK (Firestore)
- CORS & Body Parser

**Frontend:**
- HTML5
- CSS3 (Custom, no frameworks)
- Vanilla JavaScript
- Font Awesome Icons
- Google Fonts (Inter)

## Prerequisites

- Node.js (v14 or higher)
- Firebase project with Firestore enabled
- Firebase service account key

## Installation

1. **Clone or navigate to the repository:**
   ```bash
   cd d:\Jewelio\jewelio-backend
   ```

2. **Install dependencies:**
   ```bash
   npm install
   ```

3. **Configure Firebase:**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Firestore Database
   - Generate a service account key:
     - Go to Project Settings > Service Accounts
     - Click "Generate New Private Key"
     - Save the JSON file as `serviceAccountKey.json` in the project root

4. **Verify Firebase configuration:**
   - Ensure `firebase.js` points to your `serviceAccountKey.json`
   - The file should already be configured correctly

## Running the Application

1. **Start the server:**
   ```bash
   node index.js
   ```

2. **Access the application:**
   - Login Page: http://localhost:3000/login.html
   - Dashboard: http://localhost:3000/dashboard.html

3. **Login:**
   - For demo purposes, use any email and password to login
   - Example: `admin@jewelio.com` / `password123`

## API Endpoints

### Dashboard
- `GET /api/dashboard/stats` - Get dashboard statistics

### Products
- `GET /api/products` - Get all products
- `GET /api/products/:id` - Get single product
- `POST /api/products` - Create new product
- `PUT /api/products/:id` - Update product
- `DELETE /api/products/:id` - Delete product

### Orders
- `GET /api/orders` - Get all orders
- `GET /api/orders/:id` - Get single order
- `PUT /api/orders/:id/status` - Update order status
- `GET /api/orders/stats/summary` - Get order statistics

### Customers
- `GET /api/customers` - Get all customers
- `GET /api/customers/:id` - Get single customer
- `GET /api/customers/stats/summary` - Get customer statistics

### Authentication
- `POST /api/auth/signup` - User signup
- `POST /api/auth/login` - User login

## Project Structure

```
jewelio-backend/
├── middleware/
│   └── auth.js                 # Authentication middleware
├── routes/
│   ├── auth.js                 # Authentication routes
│   ├── products.js             # Product routes
│   ├── orders.js               # Order routes
│   ├── customers.js            # Customer routes
│   └── dashboard.js            # Dashboard routes
├── public/
│   ├── css/
│   │   └── admin.css           # Main stylesheet
│   └── js/
│       ├── common.js           # Shared utilities
│       ├── auth.js             # Login functionality
│       ├── dashboard.js        # Dashboard logic
│       ├── products.js         # Products management
│       ├── orders.js           # Orders management
│       └── customers.js        # Customers management
├── firebase.js                 # Firebase configuration
├── index.js                    # Main server file
├── login.html                  # Login page
├── dashboard.html              # Dashboard page
├── products.html               # Products page
├── orders.html                 # Orders page
├── customer.html               # Customers page
├── settings.html               # Settings page
└── package.json                # Dependencies
```

## Firebase Collections

The application uses the following Firestore collections:

- **products** - Product catalog
  - Fields: name, price, category, description, image, stock, createdAt
  
- **orders** - Customer orders
  - Fields: customerName, customerEmail, total, status, items, createdAt
  
- **customers** - Customer information
  - Fields: name, email, phone, address, createdAt

## Adding Sample Data

To test the dashboard, you can add sample data through the Firebase Console or use the admin interface:

1. Navigate to Products page
2. Click "Add Product"
3. Fill in the product details
4. Save

Repeat for orders and customers as needed.

## Features in Detail

### Authentication
- Simple demo authentication (stores token in localStorage)
- Protected routes (redirects to login if not authenticated)
- Logout functionality

### Dashboard
- Live statistics from Firebase
- Recent orders table
- Quick overview of store performance

### Products Management
- Add, edit, delete products
- Search products by name or category
- Image URL support
- Stock tracking

### Orders Management
- View all orders
- Update order status (Pending, Processing, Shipped, Delivered, Cancelled)
- Filter orders by status
- View detailed order information

### Customers Management
- View all customers
- Search customers
- View customer details

## Customization

### Colors
Edit the CSS variables in `public/css/admin.css`:
```css
:root {
  --primary-gold: #D4AF37;
  --dark-bg: #0F0F0F;
  --dark-card: #1A1A1A;
  /* ... more variables */
}
```

### API Base URL
Update in `public/js/common.js`:
```javascript
const API_BASE_URL = 'http://localhost:3000/api';
```

## Troubleshooting

**Server won't start:**
- Check if port 3000 is available
- Verify Firebase credentials are correct
- Ensure all dependencies are installed

**Can't login:**
- Check browser console for errors
- Verify `public/js/auth.js` is loaded correctly

**Data not loading:**
- Check Firebase connection
- Verify Firestore rules allow read/write
- Check browser console for API errors

## Future Enhancements

- Real Firebase Authentication integration
- Image upload functionality
- Advanced analytics and charts
- Email notifications
- Export data to CSV/PDF
- Multi-language support
- Dark/Light theme toggle

## License

ISC

## Support

For issues or questions, please contact the development team.

---

**Jewelio Admin Dashboard** - Manage your jewelry business with elegance ✨
