import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CartScreen(),
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.black54),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                _buildStepIndicator(),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      _buildCartItem("Diamond Ring", "47 × 55 MM"),
                      _buildCartItem("Pendant", "47 × 55 MM"),
                      const SizedBox(height: 20),
                      _buildBillDetails(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildCheckoutBar(),
          ),
        ],
      ),
    );
  }

  // ---------------- STEP INDICATOR ----------------
  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _stepCircle("1", "Cart", true),
        _stepLine(),
        _stepCircle("2", "Payment", false),
        _stepLine(),
        _stepCircle("3", "Order Placed", false),
      ],
    );
  }

  Widget _stepCircle(String num, String label, bool active) {
    Color color = active ? Colors.redAccent : Colors.grey;
    return Column(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: color,
          child: Text(
            num,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: color, fontSize: 10),
        ),
      ],
    );
  }

  Widget _stepLine() =>
      Container(width: 40, height: 1, color: Colors.grey[300]);

  // ---------------- CART ITEM ----------------
  Widget _buildCartItem(String title, String size) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.shopping_bag),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  "Size: $size",
                  style:
                      const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.red[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: const [
                Icon(Icons.remove, size: 18),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("1"),
                ),
                Icon(Icons.add, size: 18),
              ],
            ),
          )
        ],
      ),
    );
  }

  // ---------------- BILL DETAILS ----------------
  Widget _buildBillDetails() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          _billRow("Subtotal", "\$120.00"),
          _billRow("Tax", "\$12.34"),
          const Divider(),
          _billRow("Total", "\$132.34", isBold: true),
        ],
      ),
    );
  }

  Widget _billRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight:
                  isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight:
                  isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- CHECKOUT BAR ----------------
  Widget _buildCheckoutBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                "\$132.34",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Total",
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            onPressed: () {},
            child: const Text("Checkout"),
          ),
        ],
      ),
    );
  }
}