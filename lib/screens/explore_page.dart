import 'package:flutter/material.dart';
import 'cart_screen.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFBF6),
        elevation: 0,
        title: const Text(
          "Explore",
          style: TextStyle(color: Colors.black, fontSize: 28),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: const [
                Expanded(
                  child: Icon(
                    Icons.diamond,
                    size: 60,
                    color: Colors.amber,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Gold Jewellery",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text("\$25.00"),
                SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}

