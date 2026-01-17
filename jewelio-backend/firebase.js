const admin = require("firebase-admin");

const initializeFirebase = () => {
  try {
    // Prevent multiple initializations (common with nodemon)
    if (admin.apps.length > 0) {
      return admin.firestore();
    }

    // 1. Try Environment Variables
    if (process.env.FIREBASE_PROJECT_ID && process.env.FIREBASE_PRIVATE_KEY) {
      try {
        admin.initializeApp({
          credential: admin.credential.cert({
            projectId: process.env.FIREBASE_PROJECT_ID,
            privateKey: process.env.FIREBASE_PRIVATE_KEY.replace(/\\n/g, '\n'),
            clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
          })
        });
        console.log("✅ Firebase initialized successfully via Environment Variables");
        return admin.firestore();
      } catch (initErr) {
        console.error("❌ Failed to initialize Firebase with environment variables:", initErr.message);
      }
    }        

    // 2. Try Service Account JSON File
    try {
      const serviceAccount = require("./serviceAccountKey.json");
      admin.initializeApp({
        credential: admin.credential.cert(serviceAccount)
      });
      console.log("✅ Firebase initialized successfully via JSON file");
      return admin.firestore();
    } catch (e) {
      // JSON file not found or invalid
    }

    throw new Error("No valid Firebase credentials found.");
  } catch (error) {
    console.warn("⚠️  Firebase initialization error:", error.message);

    // Mock database for fallback
    return {
      collection: (name) => ({
        get: async () => ({ size: 0, forEach: () => { }, docs: [] }),
        doc: (id) => ({
          get: async () => ({ exists: false }),
          set: async () => { },
          update: async () => { },
          delete: async () => { }
        }),
        add: async (data) => ({ id: 'demo-' + Date.now() }),
        where: () => ({ get: async () => ({ size: 0, forEach: () => { } }) }),
        orderBy: () => ({ get: async () => ({ size: 0, forEach: () => { } }), limit: () => ({ get: async () => ({ size: 0, forEach: () => { } }) }), count: () => ({ get: async () => ({ data: () => ({ count: 0 }) }) }) })
      })
    };
  }
};

const firestore = initializeFirebase();

module.exports = {
  db: firestore,
  admin: admin
};
