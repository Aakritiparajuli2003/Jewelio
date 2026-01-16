import 'package:cloud_firestore/cloud_firestore.dart';

class WishlistService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Wishlist collection
  CollectionReference get _wishlistRef =>
      _firestore.collection('wishlist');

  // Cart collection
  CollectionReference get _cartRef =>
      _firestore.collection('cart');

  /// 🔹 Stream wishlist items
  Stream<QuerySnapshot> getWishlistItems() {
    return _wishlistRef.orderBy('addedAt', descending: true).snapshots();
  }

  /// ❌ Remove from wishlist
  Future<void> removeFromWishlist(String productId) async {
    await _wishlistRef.doc(productId).delete();
  }

  /// 🔄 Move item to cart
  Future<void> moveToCart(
    String productId,
    Map<String, dynamic> data,
  ) async {
    await _cartRef.doc(productId).set({
      'Name': data['Name'],
      'Image': data['Image'],
      'price': data['price'],
      'selectedColor': data['selectedColor'],
      'quantity': 1,
      'addedAt': FieldValue.serverTimestamp(),
    });

    // Remove from wishlist after adding to cart
    await removeFromWishlist(productId);
  }
}
