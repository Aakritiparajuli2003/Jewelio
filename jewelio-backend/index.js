const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const db = require("./firebase");

const app = express();
app.use(cors());
app.use(bodyParser.json());

// TEST API
app.get("/", (req, res) => {
  res.send("Jewelry Backend Running");
});

// ADD PRODUCT (Admin)
app.post("/addProduct", async (req, res) => {
  const { name, price, image } = req.body;

  await db.collection("products").add({
    name,
    price,
    image
  });

  res.send("Product Added");
});

// GET ALL PRODUCTS (Flutter)
app.get("/products", async (req, res) => {
  const snapshot = await db.collection("products").get();
  let products = [];

  snapshot.forEach(doc => {
    products.push({ id: doc.id, ...doc.data() });
  });

  res.json(products);
});

app.listen(3000, () => {
  console.log("Server running on port 3000");
});
