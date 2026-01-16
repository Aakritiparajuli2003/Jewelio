  import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase/wishlist_service.dart';

class WishlistScreen extends StatelessWidget {
  WishlistScreen({super.key});

  final WishlistService _wishlistService = WishlistService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black87),
        title: const Text(
          "My Wishlist",
          style: TextStyle(fontFamily: 'Serif', color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _wishlistService.getWishlistItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("Your wishlist is empty 💔"),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return _buildWishlistItem(
                context,
                productId: doc.id,
                data: data,
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildWishlistItem(
    BuildContext context, {
    required String productId,
    required Map<String, dynamic> data,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              data['image'],
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Size: ${data['size']}",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  "\$${data['price']}",
                  style: const TextStyle(
                    color: Color(0xFFE54D4D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Actions
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  _wishlistService.removeFromWishlist(productId);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE54D4D),
                  minimumSize: const Size(80, 30),
                ),
                onPressed: () {
                  _wishlistService.moveToCart(productId, data);
                },
                child: const Text(
                  "Add",
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}