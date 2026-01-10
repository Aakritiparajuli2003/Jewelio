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
    await db.collection("categories").add({
      "name": name,
      "description": description,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  // ------------------ PRODUCTS ------------------
  Future<void> createProduct({
    required String name,
    required String description,
    required String categoryId,
    required double price,
    required int stock,
  }) async {
    final productRef = await db.collection("products").add({
      "name": name,
      "description": description,
      "categoryId": categoryId,
      "price": price,
      "stock": stock,
      "createdAt": FieldValue.serverTimestamp(),
    });

    await productRef.collection("images").add({
      "imageUrl": "goldring.jpg",
      "uploadedAt": FieldValue.serverTimestamp(),
    });
  }
}
