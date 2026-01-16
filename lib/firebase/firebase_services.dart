import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ------------------ USERS ------------------
  Future<void> createUserProfile({
    required String name,
    required String email,
    required String phone,
    required String address,
  }) async {
    final uid = _auth.currentUser!.uid;

    await db.collection("users").doc(uid).set({
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  // ------------------ CATEGORIES ------------------
  Future<void> createCategory({
    required String name,
    required String description,
  }) async {
    await db.collection("categories").doc(name.toLowerCase()).set({
      "name": name,
      "description": description,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  // ------------------ PRODUCTS ------------------
  Future<void> createProduct({
    required String id,
    required String name,
    required String description,
    required List<String> categories,
    required double price,
    required int stock,
    required String imageUrl,
  }) async {
    final productDocRef = db.collection("products").doc(id);

    await productDocRef.set({
      "name": name,
      "description": description,
      "categories": categories,
      "price": price,
      "stock": stock,
      "createdAt": FieldValue.serverTimestamp(),
    });

    // Add product image
    await productDocRef.collection("images").add({
      "imageUrl": imageUrl,
      "uploadedAt": FieldValue.serverTimestamp(),
    });
  }

  // ------------------ CREATE ALL COLLECTIONS ------------------
  Future<void> createAllCollections() async {
    // Example categories
    await createCategory(name: "New Arrival", description: "Latest products in the store");
    await createCategory(name: "Best Seller", description: "Most popular products");
    await createCategory(name: "Gifting", description: "Perfect gifts for loved ones");

    // Example product
    await createProduct(
      id: "unique_wavy_ring",
      name: "Unique Wavy Ring",
      description: "A unique wavy ring for special occasions",
      categories: ["new_arrival", "best_seller", "gifting"],
      price: 2500,
      stock: 10,
      imageUrl: "https://res.cloudinary.com/duvm1rblo/image/upload/v1768298769/Unique_Wavy_Ring_dkprzd.webp",
    );
  }
}
