 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get _cartCollection =>
      _db.collection('users').doc(_uid).collection('cart');

  // ---------------- ADD TO CART ----------------
  Future<void> addToCart({
    required String productId,
    required String title,
    required String image,
    required String size,
    required double price,
    int quantity = 1,
  }) async {
    final docRef = _cartCollection.doc(productId);

    final doc = await docRef.get();

    if (doc.exists) {
      await docRef.update({
        'quantity': FieldValue.increment(1),
      });
    } else {
      await docRef.set({
        'title': title,
        'image': image,
        'size': size,
        'price': price,
        'quantity': quantity,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  // ---------------- REMOVE ITEM ----------------
  Future<void> removeFromCart(String productId) async {
    await _cartCollection.doc(productId).delete();
  }

  // ---------------- UPDATE QUANTITY ----------------
  Future<void> updateQuantity({
    required String productId,
    required int quantity,
  }) async {
    if (quantity <= 0) {
      await removeFromCart(productId);
    } else {
      await _cartCollection.doc(productId).update({
        'quantity': quantity,
      });
    }
  }

  // ---------------- CLEAR CART ----------------
  Future<void> clearCart() async {
    final cartItems = await _cartCollection.get();
    for (var doc in cartItems.docs) {
      await doc.reference.delete();
    }
  }

  // ---------------- CART STREAM ----------------
  Stream<QuerySnapshot<Map<String, dynamic>>> getCartItems() {
    return _cartCollection.orderBy('createdAt', descending: true).snapshots();
  }

  // ---------------- TOTAL PRICE ----------------
  Stream<double> getTotalPrice() {
    return getCartItems().map((snapshot) {
      double total = 0;
      for (var doc in snapshot.docs) {
        final data = doc.data();
        total += data['price'] * data['quantity'];
      }
      return total;
    });
  }
}