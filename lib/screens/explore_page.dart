import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({super.key});

  final List<Map<String, String>> products = [
    {
      "image": "assets/p1.jpg",
      "price": "\$23.33",
      "text": "Delicate gold necklace and matching stud earrings.",
    },
    {
      "image": "assets/p2.jpg",
      "price": "\$12.53",
      "text": "Delicate gold necklace and matching stud earrings.",
    },
    {
      "image": "assets/p3.jpg",
      "price": "\$33.63",
      "text": "Delicate gold necklace and matching stud earrings.",
    },
    {
      "image": "assets/p4.jpg",
      "price": "\$13.23",
      "text": "Delicate gold necklace and matching stud earrings.",
    },
    {
      "image": "assets/p5.jpg",
      "price": "\$18.90",
      "text": "Delicate gold necklace and matching stud earrings.",
    },
    {
      "image": "assets/p6.jpg",
      "price": "\$20.11",
      "text": "Delicate gold necklace and matching stud earrings.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 🔝 AppBar (NO back button)
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Explore",
          style: GoogleFonts.playfairDisplay(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        actions: const [
          Icon(Icons.favorite_border, color: Colors.black),
          SizedBox(width: 20),
          Icon(Icons.shopping_cart_outlined, color: Colors.black),
          SizedBox(width: 15),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 15),

            // 🔍 Search Field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.search),
                  hintText: "Search...",
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🛍 Product Grid
            Expanded(
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.70,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(14),
                          ),
                          child: Image.asset(
                            product["image"]!,
                            height: 130,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product["price"]!,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                product["text"]!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // ⬇️ Bottom Navigation (Search selected)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Search active
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.storefront), label: "Store"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }
}
