import 'package:flutter/material.dart';
import 'login_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  // 🔴 LOGOUT FUNCTION
  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF7EF), // Cream background

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
            onPressed: () {},
            icon: const Icon(Icons.favorite_border, color: Colors.black87),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black87),
              ),
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    "4",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black87),
            onPressed: () => _logout(context),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔍 Modern Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 2, 0, 3), 
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search Products...",
                    prefixIcon: const Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 📸 Banner Image
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 240,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/banner.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ⭐ Jewelio Special
            const Text(
              "Jewelio Special",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Our top picks, just for you!",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                productCard("New Arrival", "assets/new.jpg"),
                productCard("Best Seller", "assets/best.jpg"),
              ],
            ),

            const SizedBox(height: 35),

            // 🎁 Gifting Section
            const Text(
              "Gifting",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Find the perfect gift",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                height: 200,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/gift.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),

      // 🔻 Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => currentIndex = index),
        type: BottomNavigationBarType.fixed,
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

  // 🔶 Product Card Widget
  Widget productCard(String title, String img) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 160,
        height: 210,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(img),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xffF8F5EB), 
            ),
            child: Text(
              title, // ← Display product title
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.redAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
