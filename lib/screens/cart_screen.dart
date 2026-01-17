import 'package:flutter/material.dart';
import 'explore_page.dart';

// ----------------- Cart Progress Stepper -----------------
class CartProgressStepper extends StatelessWidget {
  const CartProgressStepper({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _step("1", "Cart", true),
        _line(),
        _step("2", "Payment", false),
        _line(),
        _step("3", "Order Placed", false),
      ],
    );
  }

  Widget _step(String number, String label, bool active) {
    return Column(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor:
              active ? const Color(0xFFE54D4D) : Colors.grey.shade300,
          child: Text(
            number,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: active ? const Color(0xFFE54D4D) : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _line() {
    return Expanded(
      child: Container(height: 1, color: Colors.grey.shade300),
    );
  }
}

// ----------------- Payment Screen -----------------
class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Payment"),
        backgroundColor: const Color(0xFFE54D4D),
      ),
      body: const Center(
        child: Text(
          "Payment options will be added here",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

// ----------------- Cart Screen -----------------
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double totalAmount = 132.34; // Dynamic total for bottom bar

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
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
            padding: const EdgeInsets.only(bottom: 140),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const CartProgressStepper(),
                  const SizedBox(height: 20),

                  /// Delivery Info
                  Row(
                    children: const [
                      Icon(Icons.access_time,
                          size: 20, color: Color(0xFF2D2D5E)),
                      SizedBox(width: 8),
                      Text(
                        "Delivered in 3 days",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 28),
                    child: Text(
                      "Shipment of 3 items 🚚",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildCartItem(
                    "Hearts All Over",
                    "47*55 MM",
                    "https://res.cloudinary.com/duvm1rblo/image/upload/v1768298769/Hearts_All_Over_Bracelet_i3f0xq.webp",
                  ),
                  _buildCartItem(
                    "Two Layered Solid Cable Anklet",
                    "47*55 MM",
                    "https://res.cloudinary.com/duvm1rblo/image/upload/v1768298769/Two_Layered_Solid_Cable_Anklet_haontt.webp",
                  ),
                  _buildCartItem(
                    "Twist Cross Cage Ring",
                    "47*55 MM",
                    "https://res.cloudinary.com/duvm1rblo/image/upload/v1768298768/Twist_Cross_Cage_Ring_z04kkr.webp",
                  ),

                  const SizedBox(height: 24),

                  /// Before checkout
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Before you checkout",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ExplorePage()),
                          );
                        },
                        child: const Text("See more >",
                            style: TextStyle(color: Colors.grey)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 180,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildSuggestionCard(
                            context, "Golden Pendant", "Rs23.45"),
                        _buildSuggestionCard(
                            context, "Golden Pendant", "Rs23.45"),
                        _buildSuggestionCard(
                            context, "Golden Pendant", "Rs23.45"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Bill Details
                  const Text("Bill details",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 10),
                  _billRow("Item total", "Rs 23.45"),

                  const SizedBox(height: 20),

                  /// Delivering to Home
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Delivering to Home",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold)),
                            Text("Random Address",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: const Text("Change"),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Pay Using
                  const Text("Pay Using",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 6),
                  const Text("Cash On Delivery",
                      style: TextStyle(color: Color(0xFFE54D4D))),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          /// Bottom Checkout Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10)
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE54D4D),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Rs $totalAmount",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          const Text("Total",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding:
                            const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const PaymentScreen()),
                        );
                      },
                      child: const Text(
                        "Checkout",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ----------------- Helper Widgets -----------------
  Widget _billRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildCartItem(String title, String size, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(imageUrl,
                width: 70, height: 70, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15)),
                Text("Size: $size",
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE54D4D),
              borderRadius: BorderRadius.circular(20),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: const [
                Icon(Icons.remove_circle_outline,
                    color: Colors.white, size: 18),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("1",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
                Icon(Icons.add_circle_outline,
                    color: Colors.white, size: 18),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSuggestionCard(
      BuildContext context, String title, String price) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => ExplorePage()));
      },
      child: Container(
        width: 130,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                  "https://via.placeholder.com/130",
                  height: 120,
                  fit: BoxFit.cover),
            ),
            const SizedBox(height: 8),
            Text(title,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w500)),
            Text(price,
                style:
                    const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
