import 'package:flutter/material.dart';
import 'product_detail.dart';
import 'category_products_screen.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  // 🔹 Products list
  final List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "Trendy Vee Diamond Ring",
      "price": 2388,
      "oldPrice": 3184,
      "img": "https://res.cloudinary.com/duvm1rblo/image/upload/v1768298768/Trendy_Vee_Diamond_Ring_q40z96.webp",
      "rating": 4.8,
      "reviews": 1966,
    },
    {
      "id": 2,
      "name": "Classic Textured Hoops",
      "price": 1602,
      "oldPrice": 2136,
      "img": "https://res.cloudinary.com/duvm1rblo/image/upload/v1768298765/Classic_Textured_Hoops_opbene.webp",
      "rating": 4.5,
      "reviews": 739,
    },
  ];

  // 🔹 Categories list with images
  final List<Map<String, String>> categories = [
    {
      "name": "NECKLACES",
      "image": "https://res.cloudinary.com/duvm1rblo/image/upload/v1768298765/Daisy_flower_Necklace_nnuwis.webp",
    },
    {
      "name": "RINGS",
      "image": "https://res.cloudinary.com/duvm1rblo/image/upload/v1768298766/Droplet_Blush_Ring_wohfvs.webp",
    },
    {
      "name": "EARRINGS",
      "image": "https://res.cloudinary.com/duvm1rblo/image/upload/v1768298766/gold_heart_hoop_earrings_vpby1e.webp",
    },
    {
      "name": "BRACELETS",
      "image": "https://res.cloudinary.com/duvm1rblo/image/upload/v1768298765/bangle_bracelet_sq6bif.webp",
    },
    {
      "name": "ANKLETS",
      "image": "https://res.cloudinary.com/duvm1rblo/image/upload/v1768298765/Coastal_Aura_Shell_Anklet_ju3mtx.webp",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 🔹 Header
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          "Jewelio",
          style: TextStyle(
            letterSpacing: 2,
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
        ),
        actions: const [
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 16),
          Icon(Icons.favorite_border, color: Colors.black),
          SizedBox(width: 16),
          Icon(Icons.shopping_bag_outlined, color: Colors.black),
          SizedBox(width: 12),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            // 🔹 Categories Grid
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryProductsScreen(
                              categoryId: cat['name']!.toLowerCase()),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade100,
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              cat['image']!,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            cat['name']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Top Styles Title
            const Text(
              "JEWELIO TOP STYLES",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Products Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 12,
                childAspectRatio: 0.62,
              ),
              itemBuilder: (context, index) {
                final product = products[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(product: product),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Image with badge
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              product['img'],
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 6,
                            right: 6,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              color: Colors.white70,
                              child: const Text(
                                "Buy 1 Get 1",
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Product Name
                      Text(
                        product['name'],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Price
                      Row(
                        children: [
                          Text(
                            "Rs ${product['price']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "Rs ${product['oldPrice']}",
                            style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      // Reviews
                      Text(
                        "★★★★★ (${product['reviews']})",
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),

      // 🔹 Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
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
}
