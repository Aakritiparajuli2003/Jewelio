require('dotenv').config();
const { db } = require('./firebase');

async function test() {
    console.log("--- MVC TEST ---");
    try {
        const snapshot = await db.collection('products').count().get();
        console.log("Products Count:", snapshot.data().count);

        const first = await db.collection('products').limit(1).get();
        if (!first.empty) {
            console.log("First Product:", first.docs[0].data().name);
        } else {
            console.log("No products found.");
        }
    } catch (e) {
        console.error("Test failed:", e.message);
    }
    process.exit();
}

test();
