import 'package:flutter/material.dart';
import 'explore_page.dart'; 

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
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 80),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const CartProgressStepper(),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      Icon(Icons.access_time, size: 20, color: Color(0xFF2D2D5E)),
                      SizedBox(width: 8),
                      Text(
                        "Delivered in 3 days",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 28.0),
                    child: Text("Shipment of 3 items 🚚",
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ),
                  const SizedBox(height: 20),
                  _buildCartItem(
                      "Hearts All Over",
                      "47*55 MM",
                      "https://res.cloudinary.com/duvm1rblo/image/upload/v1768298769/Hearts_All_Over_Bracelet_i3f0xq.webp"),
                  _buildCartItem(
                      "Two Layered Solid Cable Anklet",
                      "47*55 MM",
                      "https://res.cloudinary.com/duvm1rblo/image/upload/v1768298769/Two_Layered_Solid_Cable_Anklet_haontt.webp"),
                  _buildCartItem(
                      "Twist Cross Cage Ring",
                      "47*55 MM",
                      "https://res.cloudinary.com/duvm1rblo/image/upload/v1768298768/Twist_Cross_Cage_Ring_z04kkr.webp"),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Before you checkout",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ExplorePage()),
                          );
                        },
                        child: const Text("See more >", style: TextStyle(color: Colors.grey)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 180,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildSuggestionCard(context, "Golden Pendant", "Rs23.45"),
                        _buildSuggestionCard(context, "Golden Pendant", "Rs23.45"),
                        _buildSuggestionCard(context, "Golden Pendant", "Rs23.45"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // --- Checkout Button ---
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE54D4D),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  // Navigate to payment screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PaymentScreen()),
                  );
                },
                child: const Text(
                  "Checkout",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
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

  Widget _buildSuggestionCard(BuildContext context, String title, String price) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => ExplorePage()));
      },
      child: Container(
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

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: const Color(0xFFE54D4D),
      ),
      body: const Center(
        child: Text(
          "Payment options will go here",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
