require('dotenv').config();
const db = require('./firebase');

async function seedAdmin() {
    console.log("🚀 Starting Admin Seeding...");

    const adminData = {
        email: "admin@jwelio.com",
        password: "admin@12", // Plain text as per user request for initial setup
        role: "admin",
        name: "Super Admin",
        created_at: new Date().toISOString()
    };

    try {
        // We use a fixed ID for the admin to make it easy to manage or update
        const adminId = "main-admin";
        await db.collection('admin').doc(adminId).set(adminData);

        console.log("✅ Admin seeded successfully!");
        console.log(`- Email: ${adminData.email}`);
        console.log(`- Password: ${adminData.password}`);
    } catch (error) {
        console.error("❌ Seeding failed:", error.message);
    }
    process.exit();
}

seedAdmin();
