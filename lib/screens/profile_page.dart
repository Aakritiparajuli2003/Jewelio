import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
         
          Stack(
            children: [
              Container(
                height: 260,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/profile_bg.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

             
              Positioned(
                top: 40,
                left: 16,
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
              Positioned(
                top: 40,
                right: 16,
                child: Icon(Icons.favorite_border, color: Colors.white),
              ),

              
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: const [
                    CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage("assets/profile.jpg"),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Scobby DOO",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),

          // 📄 Account Overview
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: const BoxDecoration(
                color: Color(0xFFFFFBF5),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Account Overview",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  profileTile(
                      icon: Icons.person_outline, title: "My Profile"),
                  profileTile(
                      icon: Icons.local_shipping_outlined,
                      title: "My Orders"),
                  profileTile(
                      icon: Icons.currency_rupee_outlined,
                      title: "Refund"),
                  profileTile(
                      icon: Icons.favorite_border, title: "Wishlist"),
                  profileTile(
                      icon: Icons.logout, title: "Log out"),
                ],
              ),
            ),
          ),
        ],
      ),

      // 🔽 Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: "Cart"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  // 🔹 Reusable List Tile
  Widget profileTile({required IconData icon, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 26),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}
