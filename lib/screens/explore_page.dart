import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_screen.dart';
import 'product_detail.dart'; // ✅ keep this import

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController searchController = TextEditingController();

  String selectedCategory = "All";
  String searchText = "";

  final List<String> categories = [
    "All",
    "NECKLACES",
    "RINGS",
    "EARRINGS",
    "BRACELETS",
    "ANKLETS",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF7EF),

      // ---------------- APP BAR ----------------
      appBar: AppBar(
        backgroundColor: const Color(0xffFAF7EF),
        elevation: 0,
        title: Text(
          "Explore",
          style: GoogleFonts.playfairDisplay(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black87),
            onPressed: () {},
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black87),
                onPressed: () {},
              ),
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    "4+",
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      // ---------------- BODY ----------------
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // 🔍 Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.black26),
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() => searchText = value.toLowerCase());
                },
                decoration: InputDecoration(
                  icon: const Icon(Icons.search),
                  hintText: "Search Product",
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.playfairDisplay(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // 🏷 Category Chips
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category == selectedCategory;

                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() => selectedCategory = category);
                      },
                      selectedColor: Colors.black,
                      backgroundColor: Colors.transparent,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                      shape: StadiumBorder(
                        side: BorderSide(color: Colors.black26),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 18),

            // 🛍 Firestore Product Grid
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('products')
                    .orderBy('created_at', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No products found"));
                  }

                  final products = snapshot.data!.docs.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final name = (data['name'] ?? '').toString().toLowerCase();
                    final category = (data['category'] ?? 'All').toString();

                    final matchesSearch = name.contains(searchText);
                    final matchesCategory =
                        selectedCategory == "All" || category == selectedCategory;

                    return matchesSearch && matchesCategory;
                  }).toList();

                  return GridView.builder(
                    itemCount: products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.72,
                    ),
                    itemBuilder: (context, index) {
                      final data = products[index].data() as Map<String, dynamic>;

                      final image = data['image'] ?? data['imageUrl'] ?? 'https://via.placeholder.com/300';
                      final price = data['price'] ?? 0;
                      final name = data['name'] ?? 'No Name';

                      return GestureDetector(
                        onTap: () {
                          // ✅ FIX: Use the correct ProductDetail class
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetail(
                                product: data,
                                currentUserId: "current_user_id_here", // replace with actual user ID
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(18)),
                                    child: Image.network(
                                      image,
                                      height: 160,
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
                                          "RS $price",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // ❤️ Wishlist Icon
                            Positioned(
                              right: 10,
                              top: 10,
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 16,
                                  color: Colors.pink.shade200,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // ---------------- BOTTOM NAV ----------------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
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
