import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final double total; // <-- add total here

  const PaymentScreen({
    super.key,
    required this.total, // <-- required parameter
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.arrow_back),
                  Text(
                    "Payment",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Serif",
                    ),
                  ),
                  Icon(Icons.menu),
                ],
              ),

              const SizedBox(height: 25),

              /// Step Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  StepItem(number: "1", label: "Cart", active: false),
                  Expanded(child: Divider(thickness: 1)),
                  StepItem(number: "2", label: "Payment", active: true),
                  Expanded(child: Divider(thickness: 1)),
                  StepItem(number: "3", label: "Order Placed", active: false),
                ],
              ),

              const SizedBox(height: 30),

              /// Checkout Header
              const Text(
                "Checkout",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                "Order number: #2322-323",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10),
              const Text(
                "Hey there, you are almost there! Choose your preferred method of payment, fill in the details, and you are good to go",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 25),

              /// Payment Options
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  PaymentOption(title: "Card Payment", selected: true),
                  PaymentOption(title: "PayPal"),
                  PaymentOption(title: "Cash on delivery"),
                ],
              ),

              const SizedBox(height: 30),

              /// Card Details
              const Text(
                "Credit card details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text("Enter your card details in the boxes below"),

              const SizedBox(height: 15),

              Row(
                children: [
                  /// Input Fields
                  Expanded(
                    child: Column(
                      children: [
                        textField("Name"),
                        const SizedBox(height: 12),
                        textField("Card Number", isError: true),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(child: textField("Exp. Date")),
                            const SizedBox(width: 10),
                            Expanded(child: textField("CVV")),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 15),

                  /// Image Card
                  Container(
                    height: 180,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade300,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.credit_card,
                      color: Colors.white,
                      size: 60,
                    ),
                  )
                ],
              ),

              const SizedBox(height: 30),

              /// Order Summary
              const Text(
                "Order Summary",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              // Instead of hard-coded totals, show actual total
              summaryRow("Item totals", "₹${total.toStringAsFixed(2)}"),
              summaryRow("Handling Charge", "₹3.45"),
              summaryRow("Delivery Charge", "₹5.45",
                  subtitle: "Shop for ₹2 more to get free delivery"),

              const Divider(height: 30),

              summaryRow(
                "Grand Total",
                "₹${(total + 3.45 + 5.45).toStringAsFixed(2)}",
                isBold: true,
              ),

              const SizedBox(height: 30),

              /// Pay Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Proceed to Pay",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              /// Bottom Buttons
              Row(
                children: [
                  Expanded(child: outlinedButton("Cancel Order")),
                  const SizedBox(width: 15),
                  Expanded(child: outlinedButton("Return Policy")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helpers
  static Widget textField(String hint, {bool isError = false}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: isError ? Colors.red : Colors.grey.shade300),
        ),
      ),
    );
  }

  static Widget summaryRow(String title, String value,
      {bool isBold = false, String? subtitle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
          if (subtitle != null)
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.red),
            ),
        ],
      ),
    );
  }

  static Widget outlinedButton(String text) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      onPressed: () {},
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}

/// Step Widget
class StepItem extends StatelessWidget {
  final String number;
  final String label;
  final bool active;

  const StepItem({
    super.key,
    required this.number,
    required this.label,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: active ? Colors.red : Colors.grey,
          child: Text(number, style: const TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: active ? Colors.red : Colors.grey),
        ),
      ],
    );
  }
}

/// Payment Option Button
class PaymentOption extends StatelessWidget {
  final String title;
  final bool selected;

  const PaymentOption({
    super.key,
    required this.title,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: selected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        boxShadow: selected
            ? [const BoxShadow(color: Colors.black12, blurRadius: 6)]
            : [],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(title),
    );
  }
}
