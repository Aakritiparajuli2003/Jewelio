import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/product_card.dart';
import 'explore_page.dart';
import 'cart_screen.dart';
import 'profile_page.dart';
import 'store_page.dart';
import 'wishlist_screen.dart'; // ✅ import wishlist screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void _goToExplorePage() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ExplorePage()));
  }

  void _goToCartPage() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
  }

  void _goToProfilePage() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage()));
  }

  void _goToWishlistPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => WishlistScreen()), // ✅ open wishlist
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF7EF),
      appBar: AppBar(
        backgroundColor: const Color(0xffFAF7EF),
        elevation: 0,
        title: const Text(
          "Jewelio",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _goToWishlistPage, // ✅ wishlist button
            icon: const Icon(Icons.favorite_border, color: Colors.black87),
          ),
          IconButton(
            onPressed: _goToCartPage,
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black87),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: GestureDetector(
                onTap: _goToExplorePage,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(40, 0, 0, 0),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 8),
                      Text("Search Products...", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),

            // Banner
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: const DecorationImage(
                  image: AssetImage("assets/banner.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // -------- New Arrival & Best Seller --------
            _sectionTitle("Jewelio Special", "Our top picks, just for you!"),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(child: _categoryCard("new_arrival", "New Arrival")),
                const SizedBox(width: 15),
                Expanded(child: _categoryCard("best_seller", "Best Seller")),
              ],
            ),

            const SizedBox(height: 35),

            // -------- Gifting --------
            _sectionTitle("Gifting", "Find the perfect gift"),
            const SizedBox(height: 20),

            SizedBox(
              height: 210,
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('products')
                    .where('category', isEqualTo: 'gifting')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final products = snapshot.data!.docs;

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        title: product['name'],
                        img: product['image'],
                        price: product['price'].toString(),
                        badge: "Gifting",
                        onTap: () {},
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),

      // ---------------- BOTTOM NAV ----------------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() => currentIndex = index);
          if (index == 1) _goToExplorePage();
          if (index == 3) _goToCartPage();
          if (index == 4) _goToProfilePage();
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StorePage()),
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

  // -------- Helper Widgets --------
  Widget _categoryCard(String category, String badge) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('products').where('category', isEqualTo: category).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();
        if (snapshot.data!.docs.isEmpty) return const SizedBox();

        final product = snapshot.data!.docs.first;
        return ProductCard(
          title: product['name'],
          img: product['image'],
          price: product['price'].toString(),
          badge: badge,
          onTap: () {},
        );
      },
    );
  }

  Widget _sectionTitle(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 5),
          Text(subtitle, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
