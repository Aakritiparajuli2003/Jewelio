import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // ------------------ USERS ------------------
  Future<void> createUser() async {
    await db.collection("users").add({
      "name": "Test User",
      "email": "test@gmail.com",
      "password": "hashed_password",
      "phone": "9800000000",
      "address": "Kathmandu",
      "created_at": DateTime.now(),
    });
  }

  // ------------------ CATEGORIES ------------------
  Future<void> createCategory() async {
    await db.collection("categories").add({
      "name": "Rings",
      "description": "Golden rings",
    });
  }

  // ------------------ PRODUCTS ------------------
  Future<void> createProduct() async {
    DocumentReference productRef =
        await db.collection("products").add({
      "name": "Gold Ring",
      "description": "24k pure gold",
      "category_id": "category_id_here",
      "price": 1500.0,
      "stock": 5,
      "image_url": "",
      "created_at": DateTime.now(),
    });

    // SUBCOLLECTION: IMAGES
    await productRef.collection("images").add({
      "image_url": "goldring.jpg",
      "uploaded_at": DateTime.now(),
    });

    // SUBCOLLECTION: REVIEWS
    await productRef.collection("reviews").add({
      "user_id": "user_id_here",
      "rating": 5,
      "comment": "Excellent product!",
      "created_at": DateTime.now(),
    });
  }

  // ------------------ ADMIN ------------------
  Future<void> createAdmin() async {
    await db.collection("admin").add({
      "username": "admin",
      "email": "admin@gmail.com",
      "password": "hashed",
      "role": "SuperAdmin",
      "created_at": DateTime.now(),
    });
  }

  // ------------------ CREATE ALL ------------------
  Future<void> createAllCollections() async {
    await createUser();
    await createCategory();
    await createProduct();
    await createAdmin();
  }
}
