import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Import your actual screens
import 'home_screen.dart';
import 'store_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  // BottomNavigationBar current index
  int currentIndex = 1; // Set 1 because ExplorePage corresponds to index 1

  // Sample products
  final List<Map<String, String>> products = [
    {"image": "assets/p1.jpg", "price": "\$23.33", "text": "Delicate gold necklace and matching stud earrings."},
    {"image": "assets/p2.jpg", "price": "\$12.53", "text": "Delicate gold necklace and matching stud earrings."},
    {"image": "assets/p3.jpg", "price": "\$33.63", "text": "Delicate gold necklace and matching stud earrings."},
    {"image": "assets/p4.jpg", "price": "\$13.23", "text": "Delicate gold necklace and matching stud earrings."},
    {"image": "assets/p5.jpg", "price": "\$18.90", "text": "Delicate gold necklace and matching stud earrings."},
    {"image": "assets/p6.jpg", "price": "\$20.11", "text": "Delicate gold necklace and matching stud earrings."},
  ];

  // BottomNavigationBar pages
  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      const HomePage(),
      const ExplorePage(), // Current page
      const StoreScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              //------------------------------------
              // APP BAR ROW (Title + Icons)
              //------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Explore",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.favorite_border, size: 28),
                      SizedBox(width: 20),
                      Icon(Icons.shopping_cart_outlined, size: 28),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              //------------------------------------
              // SEARCH FIELD
              //------------------------------------
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
              //------------------------------------
              // PRODUCT GRID
              //------------------------------------
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
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
      ),
      //------------------------------------
      // BOTTOM NAVIGATION BAR
      //------------------------------------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });

          // Avoid pushing the same ExplorePage again
          if (index != 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => pages[index]),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Store"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
