import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../provider/cart_provider.dart';

class ProductDetail extends StatefulWidget {
  final Map<String, dynamic> product;
  final String currentUserId; // pass logged-in user ID

  const ProductDetail({super.key, required this.product, required this.currentUserId});

  @override
  State<ProductDetail> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetail> {
  int quantity = 1;
  int selectedColor = 0;
  bool isWishlisted = false;

  final List<Color> colors = [
    const Color(0xFFE95B3A),
    Colors.yellow,
    Colors.black,
  ];

  double averageRating = 0;
  int reviewCount = 0;
  double userRating = 5;
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchRatings();
  }

  // 🔹 Fetch ratings safely
  Future<void> fetchRatings() async {
    final reviewsSnapshot = await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.product['id'])
        .collection('reviews')
        .get();

    final reviews = reviewsSnapshot.docs;
    if (reviews.isEmpty) {
      if (!mounted) return;
      setState(() {
        averageRating = 0;
        reviewCount = 0;
      });
      return;
    }

    double totalRating = 0;
    for (var review in reviews) {
      totalRating += review['rating'];
    }

    if (!mounted) return;
    setState(() {
      averageRating = double.parse((totalRating / reviews.length).toStringAsFixed(1));
      reviewCount = reviews.length;
    });
  }

  // 🔹 Submit review safely
  Future<void> submitReview() async {
    if (commentController.text.isEmpty) return;

    await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.product['id'])
        .collection('reviews')
        .add({
      'user_id': widget.currentUserId,
      'rating': userRating,
      'comment': commentController.text,
      'created_at': FieldValue.serverTimestamp(),
    });

    commentController.clear();
    await fetchRatings();

    if (!mounted) return; // Prevent async context error
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Review submitted!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFBF5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Product Details",
          style: TextStyle(
            fontSize: 22,
            fontFamily: "Serif",
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isWishlisted ? Icons.favorite : Icons.favorite_border,
              color: isWishlisted ? Colors.red : Colors.black,
            ),
            onPressed: () => setState(() => isWishlisted = !isWishlisted),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 PRODUCT IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                product['img'],
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 12),

            // 🔹 IMAGE DOTS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == 0 ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 TITLE + RATING
            Row(
              children: [
                Expanded(
                  child: Text(
                    product['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(Icons.star, color: Colors.red, size: 18),
                const SizedBox(width: 4),
                Text(
                  "$averageRating ($reviewCount Reviews)",
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 🔹 DESCRIPTION
            Text(
              product['description'],
              style: const TextStyle(color: Colors.black87),
            ),

            const SizedBox(height: 24),

            // 🔹 PRICE
            const Text("Price"),
            const SizedBox(height: 4),
            Text(
              "Rs ${product['price']}",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 COLORS
            Row(
              children: List.generate(
                colors.length,
                (index) => GestureDetector(
                  onTap: () => setState(() => selectedColor = index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: colors[index],
                      shape: BoxShape.circle,
                      border: selectedColor == index
                          ? Border.all(color: Colors.black, width: 2)
                          : null,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 🔹 QUANTITY + ADD TO CART
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Quantity
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) setState(() => quantity--);
                        },
                      ),
                      Text(
                        quantity.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => setState(() => quantity++),
                      ),
                    ],
                  ),
                ),

                // Add to cart
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .addToCart(product, quantity);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Added to cart 🛒"),
                      ),
                    );
                  },
                  child: const Text(
                    "Add to cart",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // 🔹 ADD REVIEW SECTION
            const Text(
              "Add Your Review",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Your Rating: $userRating"),
            Slider(
              value: userRating,
              min: 1,
              max: 5,
              divisions: 4,
              label: "$userRating",
              onChanged: (value) {
                setState(() => userRating = value);
              },
            ),
            TextField(
              controller: commentController,
              decoration: const InputDecoration(
                hintText: "Write your review",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: submitReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: const Text("Submit Review"),
            ),
          ],
        ),
      ),
    );
  }
}
