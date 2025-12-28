import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black87),
        title: const Text(
          "My Cart",
          style: TextStyle(fontFamily: 'Serif', color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black87),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // --- Progress Stepper ---
              const CartProgressStepper(),
              const SizedBox(height: 20),

              // --- Delivery Info ---
              Row(
                children: [
                  const Icon(Icons.access_time, size: 20, color: Color(0xFF2D2D5E)),
                  const SizedBox(width: 8),
                  const Text(
                    "Delivered in 3 days",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 28.0),
                child: Text("Shipment of 3 items 🚚", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ),
              const SizedBox(height: 20),

              // --- Cart Items List ---
              _buildCartItem("Diamond Ring", "47*55 MM", "https://via.placeholder.com/100"),
              _buildCartItem("Pendant", "47*55 MM", "https://via.placeholder.com/100"),
              _buildCartItem("Black Pendant", "47*55 MM", "https://via.placeholder.com/100"),

              const SizedBox(height: 20),

              // --- Suggestions Section ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Before you checkout", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  TextButton(onPressed: () {}, child: const Text("See more >", style: TextStyle(color: Colors.grey))),
                ],
              ),
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildSuggestionCard("Golden Pendant", "\$23.45"),
                    _buildSuggestionCard("Golden Pendant", "\$23.45"),
                    _buildSuggestionCard("Golden Pendant", "\$23.45"),
                  ],
                ),
              ),
              const SizedBox(height: 100), // Space for bottom bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartItem(String title, String size, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(imageUrl, width: 70, height: 70, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text("Size: $size", style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE54D4D),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: const [
                Icon(Icons.remove_circle_outline, color: Colors.white, size: 18),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("1", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                Icon(Icons.add_circle_outline, color: Colors.white, size: 18),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSuggestionCard(String title, String price) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network("https://via.placeholder.com/130", height: 120, fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          Text(price, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}

class CartProgressStepper extends StatelessWidget {
  const CartProgressStepper({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _stepCircle("1", "Cart", true),
        Expanded(child: Container(height: 1, color: Colors.grey.shade300)),
        _stepCircle("2", "Payment", false),
        Expanded(child: Container(height: 1, color: Colors.grey.shade300)),
        _stepCircle("3", "Order Placed", false),
      ],
    );
  }

  Widget _stepCircle(String number, String label, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: isActive ? const Color(0xFFE54D4D) : Colors.grey.shade300,
          child: Text(number, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 10, color: isActive ? const Color(0xFFE54D4D) : Colors.grey)),
      ],
    );
  }
}