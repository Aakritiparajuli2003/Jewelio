const admin = require("firebase-admin");

let db = null;

try {
  const serviceAccount = require("./serviceAccountKey.json");

  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
  });

  db = admin.firestore();
  console.log("✅ Firebase initialized successfully");
} catch (error) {
  console.warn("⚠️  Firebase not configured. Using mock database.");
  console.warn("   To enable Firebase, add serviceAccountKey.json to the project root.");

  // Mock database for demo purposes
  db = {
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
      orderBy: () => ({ get: async () => ({ size: 0, forEach: () => { } }), limit: () => ({ get: async () => ({ size: 0, forEach: () => { } }) }) })
    })
  };
}

module.exports = db;
