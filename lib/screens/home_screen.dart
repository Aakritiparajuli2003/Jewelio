import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Jewelio",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.favorite_border)),
          Stack(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                  child: const Text(
                    "4",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              )
            ],
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔍 Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search Product",
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 🖼 Banner / Slider Placeholder
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: AssetImage("assets/banner.jpg"), // replace your image
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Jewelio Special",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text("Our top picks, just for you!",
                style: TextStyle(fontSize: 14)),

            const SizedBox(height: 10),

            // 🆕 New Arrival & Best Seller Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                productCard("New Arrival", "assets/new.jpg"),
                productCard("Best Seller", "assets/best.jpg"),
              ],
            ),

            const SizedBox(height: 25),

            const Text("Gifting",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text("Find the perfect gift",
                style: TextStyle(fontSize: 14)),

            const SizedBox(height: 15),

            // 🎁 Gift Banner
            Container(
              height: 170,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: AssetImage("assets/gift.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      // 🔽 Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() => currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Store"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  // 🔹 Product Card Widget
  Widget productCard(String title, String imagePath) {
    return Container(
      width: 160,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.6),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        child: Center(
          child: Text(title,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
        ),
      ),
    );
  }
}
