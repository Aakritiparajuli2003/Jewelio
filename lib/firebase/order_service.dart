import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'cart_service.dart';

class OrderService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CartService cartService = CartService();

  String get _uid => _auth.currentUser!.uid;

  Future<void> placeOrder(double totalAmount) async {
    final cartSnapshot = await _db
        .collection('users')
        .doc(_uid)
        .collection('cart')
        .get();

    if (cartSnapshot.docs.isEmpty) return;

    final items = cartSnapshot.docs.map((doc) => doc.data()).toList();

    await _db.collection('orders').add({
      'userId': _uid,
      'items': items,
      'totalAmount': totalAmount,
      'status': 'Pending',
      'createdAt': FieldValue.serverTimestamp(),
    });

    /// Clear cart after order
    await cartService.clearCart();
  }
}
