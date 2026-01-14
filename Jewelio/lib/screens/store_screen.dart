// import 'package:flutter/material.dart';
// import 'home_screen.dart';
// import 'checkout_screen.dart';
// import 'profile_page.dart';
// import 'product_detail.dart'; // ✅ Correct file name

// class StoreScreen extends StatefulWidget {
//   const StoreScreen({Key? key}) : super(key: key);

//   @override
//   State<StoreScreen> createState() => _StoreScreenState();
// }

// class _StoreScreenState extends State<StoreScreen> {
//   int currentIndex = 2; // Store tab active

//   final List<Map<String, String>> storeProducts = [
//     {"image": "assets/p1.jpg", "name": "Gold Necklace", "price": "RS 2,499"},
//     {"image": "assets/p2.jpg", "name": "Silver Bracelet", "price": "RS 1,299"},
//     {"image": "assets/p3.jpg", "name": "Diamond Ring", "price": "RS 5,499"},
//     {"image": "assets/p4.jpg", "name": "Pearl Earrings", "price": "RS 1,799"},
//     {"image": "assets/p5.jpg", "name": "Gold Ring", "price": "RS 2,999"},
//     {"image": "assets/p6.jpg", "name": "Silver Necklace", "price": "RS 1,199"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffFAF7EF),
//       appBar: AppBar(
//         backgroundColor: const Color(0xffFAF7EF),
//         elevation: 0,
//         title: const Text(
//           "Store",
//           style: TextStyle(
//             fontSize: 32,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         child: GridView.builder(
//           itemCount: storeProducts.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 12,
//             mainAxisSpacing: 12,
//             childAspectRatio: 0.70,
//           ),
//           itemBuilder: (context, index) {
//             final product = storeProducts[index];
//             return GestureDetector(
//               onTap: () {
//                 // ✅ Navigate to product_detail.dart page
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const productdetail(),
//                   ),
//                 );
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(14),
//                   border: Border.all(color: Colors.black12),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.vertical(
//                         top: Radius.circular(14),
//                       ),
//                       child: Image.asset(
//                         product["image"]!,
//                         height: 130,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             product["price"]!,
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 6),
//                           Text(
//                             product["name"]!,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(fontSize: 14),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),

//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex,
//         selectedItemColor: Colors.redAccent,
//         unselectedItemColor: Colors.grey,
//         type: BottomNavigationBarType.fixed,
//         onTap: (index) {
//           setState(() => currentIndex = index);
//           switch (index) {
//             case 0:
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (_) => const HomePage()),
//               );
//               break;
//             case 1:
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (_) => const HomePage()), // Or ExploreScreen
//               );
//               break;
//             case 2:
//               // Already in Store
//               break;
//             case 3:
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (_) => const CheckoutScreen()),
//               );
//               break;
//             case 4:
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (_) => const ProfilePage()),
//               );
//               break;
//           }
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
//           BottomNavigationBarItem(icon: Icon(Icons.storefront), label: "Store"),
//           BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: "Cart"),
//           BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }
