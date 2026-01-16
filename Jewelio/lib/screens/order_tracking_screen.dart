import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderTrackingScreen extends StatelessWidget {
  final String orderId;

  // ✅ Use super.key instead of Key? key
  const OrderTrackingScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final ordersCollection = FirebaseFirestore.instance.collection('orders');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Track Order"),
        backgroundColor: Colors.redAccent,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: ordersCollection.doc(orderId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text("Order not found"),
            );
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          // Example statuses
          final status = data['status'] ?? 'Pending';
          final placedAt = data['createdAt'] != null
              ? (data['createdAt'] as Timestamp).toDate()
              : null;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Order #$orderId",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                if (placedAt != null)
                  Text(
                    "Placed on: ${placedAt.day}/${placedAt.month}/${placedAt.year}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                const SizedBox(height: 30),
                
                // Status Steps
                _buildStep("Order Placed", status == 'Placed' || status == 'Shipped' || status == 'Delivered'),
                _buildStep("Shipped", status == 'Shipped' || status == 'Delivered'),
                _buildStep("Out for Delivery", status == 'Out for Delivery' || status == 'Delivered'),
                _buildStep("Delivered", status == 'Delivered'),

                const Spacer(),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Back",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStep(String title, bool completed) {
    return Row(
      children: [
        Icon(
          completed ? Icons.check_circle : Icons.radio_button_unchecked,
          color: completed ? Colors.redAccent : Colors.grey,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: completed ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }
}
