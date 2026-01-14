import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          "Checkout",
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Step Indicator (Payment Active)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _StepItem("1", "Cart", false),
                _StepLine(),
                _StepItem("2", "Payment", true),
                _StepLine(),
                _StepItem("3", "Order Placed", false),
              ],
            ),

            const SizedBox(height: 30),

            // Delivery Address
            const Text(
              "Delivery Address",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Home\nRandom Address",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Change"),
                  )
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Payment Method
            const Text(
              "Payment Method",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            _PaymentTile(
              icon: Icons.money,
              title: "Cash On Delivery",
              selected: true,
            ),
            _PaymentTile(
              icon: Icons.credit_card,
              title: "Credit / Debit Card",
              selected: false,
            ),
            _PaymentTile(
              icon: Icons.account_balance_wallet,
              title: "Wallet",
              selected: false,
            ),

            const Spacer(),

            // Bill Summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Total Amount",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text("Rs 2,499",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),

      // Bottom Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            // Navigate to Order Placed screen
          },
          child: const Text(
            "Place Order",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

/* ---------------- Widgets ---------------- */

class _StepItem extends StatelessWidget {
  final String number;
  final String label;
  final bool active;

  const _StepItem(this.number, this.label, this.active);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: active ? Colors.red : Colors.grey,
          child: Text(number,
              style: const TextStyle(color: Colors.white, fontSize: 12)),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                color: active ? Colors.red : Colors.grey, fontSize: 12)),
      ],
    );
  }
}

class _StepLine extends StatelessWidget {
  const _StepLine();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(height: 1, color: Colors.grey.shade400),
    );
  }
}

class _PaymentTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;

  const _PaymentTile({
    required this.icon,
    required this.title,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected ? Colors.red : Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.red),
          const SizedBox(width: 12),
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const Spacer(),
          if (selected)
            const Icon(Icons.check_circle, color: Colors.red),
        ],
      ),
    );
  }
}
