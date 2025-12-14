//import 'package:flutter/material.dart';

//class CartScreen extends StatefulWidget {
  //const CartScreen({super.key});

  //@override
  //State<CartScreen> createState() => _CartScreenState();
//}

//class _CartScreenState extends State<CartScreen> {
  //@override
  //Widget build(BuildContext context) {
    //return const Placeholder():
  //}
//}



import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String price;
  final String description;

  const ProductCard({
    Key? key,
    required this.image,
    required this.price,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // 🖼 Product Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: Image.asset(
              image,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // 📦 Product Info
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // 💰 Price
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                // 📝 Description
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
