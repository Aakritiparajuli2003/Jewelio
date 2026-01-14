require('dotenv').config();
console.log("PROJECT_ID:", process.env.FIREBASE_PROJECT_ID || "MISSING");
console.log("CLIENT_EMAIL:", process.env.FIREBASE_CLIENT_EMAIL || "MISSING");
console.log("PRIVATE_KEY LENGTH:", process.env.FIREBASE_PRIVATE_KEY ? process.env.FIREBASE_PRIVATE_KEY.length : "MISSING");
process.exit();
