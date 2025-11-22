import 'package:flutter/material.dart';
import 'package:comission_shop/drawer.dart'; // Ensure this exists
import 'package:comission_shop/payment.dart'; // Ensure this exists

// Product Model
class Product {
  final String name;
  final String imagePath;
  final double pricePerPound;
  int quantityInPounds;

  Product({
    required this.name,
    required this.imagePath,
    required this.pricePerPound,
    this.quantityInPounds = 1,
  });
}

class PRODUCTS extends StatefulWidget {
  const PRODUCTS({super.key});

  @override
  State<PRODUCTS> createState() => _PRODUCTSState();
}

class _PRODUCTSState extends State<PRODUCTS> {
  // List of Products available for sale
  final List<Product> availableProducts = [
    Product(name: "Wheat", imagePath: 'wheat.jpg', pricePerPound: 3850),
    Product(name: "Rice", imagePath: 'rice.jpg', pricePerPound: 5200),
    Product(name: "Corn", imagePath: 'corn.jpg', pricePerPound: 3750),
    Product(name: "Aggery", imagePath: 'gurr2.jpg', pricePerPound: 7880),
    Product(name: "Sesame", imagePath: 'til.webp', pricePerPound: 11500),
    Product(name: "Canola", imagePath: 'canola.jpg', pricePerPound: 8560),
    Product(name: "Brown Sugar", imagePath: 'sugar.webp', pricePerPound: 9010),
    Product(name: "Pearl Millet", imagePath: 'bajra.jpg', pricePerPound: 3000),
    Product(name: "Barley", imagePath: 'barley.jpg', pricePerPound: 3000),
  ];

  // Cart List
  final List<Product> cart = [];

  // 1. Add to Cart Logic
  void _addToCart(Product product) {
    setState(() {
      // Check if product is already in cart
      int index = cart.indexWhere((item) => item.name == product.name);

      if (index != -1) {
        // Update quantity if exists
        cart[index].quantityInPounds += product.quantityInPounds;
      } else {
        // Add new product to cart
        cart.add(
          Product(
            name: product.name,
            imagePath: product.imagePath,
            pricePerPound: product.pricePerPound,
            quantityInPounds: product.quantityInPounds,
          ),
        );
      }

      // Reset the quantity counter on the card
      product.quantityInPounds = 1;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${product.name} added to cart!'), duration: const Duration(milliseconds: 500)),
      );
    });
  }

  // 2. Remove from Cart Logic
  void _removeFromCart(Product product) {
    setState(() {
      cart.removeWhere((item) => item.name == product.name);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${product.name} removed from cart.')),
      );
    });
  }

  // 3. Build Individual Product Card
  Widget _buildProductCard(Product product, double screenWidth) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: const EdgeInsets.all(10),
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueGrey.shade100,
              image: DecorationImage(
                image: AssetImage(product.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 5),
                Text(
                  'Rs ${product.pricePerPound.toStringAsFixed(0)} / lb',
                  style: const TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),

                // Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Quantity Adjuster
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (product.quantityInPounds > 1) {
                                  product.quantityInPounds--;
                                }
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(Icons.remove, size: 20, color: Colors.red),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '${product.quantityInPounds}',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                product.quantityInPounds++;
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(Icons.add, size: 20, color: Colors.green),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text('lb', style: TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                    ),

                    // Add Button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: InkWell(
                        onTap: () => _addToCart(product),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                          child: Row(
                            children: [
                              Icon(Icons.add_shopping_cart, size: 20, color: Colors.black),
                              SizedBox(width: 5),
                              Text("Add", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 4. Build Cart Summary (The Logic Fix)
  Widget _buildCartSummary(double screenWidth) {
    // --- LOGIC START ---
    // Calculate Subtotal
    double subtotal = cart.fold(
      0.0,
          (sum, item) => sum + (item.pricePerPound * item.quantityInPounds),
    );

    // Calculate Commission (4%)
    double commission = subtotal * 0.04;

    // Calculate Final Total (Subtotal + Commission)
    // This variable 'finalTotal' will be passed to the payment screen
    double finalTotal = subtotal + commission;
    // --- LOGIC END ---

    return Container(
      width: screenWidth,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade800,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "🛒 Your Shopping Cart",
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Divider(color: Colors.amber),

          // Cart Items List
          ...cart.map((item) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${item.name} (${item.quantityInPounds} lb)',
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Text(
                        'Rs ${(item.pricePerPound * item.quantityInPounds).toStringAsFixed(0)}',
                        style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () => _removeFromCart(item),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(color: Colors.red.shade700, borderRadius: BorderRadius.circular(5)),
                          child: const Icon(Icons.delete, size: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),

          if (cart.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Center(child: Text("Cart is empty.", style: TextStyle(color: Colors.grey, fontSize: 16))),
            ),

          const SizedBox(height: 15),
          const Divider(color: Colors.white24),

          // Totals Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Subtotal:", style: TextStyle(color: Colors.white, fontSize: 16)),
              Text('Rs ${subtotal.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Commission (4%):", style: TextStyle(color: Colors.white, fontSize: 16)),
              Text('Rs ${commission.toStringAsFixed(0)}', style: const TextStyle(color: Colors.redAccent, fontSize: 16)),
            ],
          ),
          const Divider(color: Colors.amber),

          // Final Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Final Total:", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              Text(
                'Rs ${finalTotal.toStringAsFixed(0)}', // Display finalTotal
                style: const TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Proceed Button
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: cart.isEmpty ? Colors.grey : Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: cart.isEmpty
                  ? null
                  : () {
                // Pass 'finalTotal' to the payment screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => payment(totalAmount: finalTotal),
                  ),
                );
              },
              child: const Center(
                child: Text(
                  "Proceed to Payment",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Center(
          child: Text(
            "Products",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 15),
            child: Center(
              child: Text(
                '${cart.length}',
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.shopping_cart, color: Colors.black),
          ),
        ],
      ),
      drawer: const appdrawer(), // Assuming 'drawer.dart' exports 'appdrawer'
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: availableProducts.map((product) {
                return _buildProductCard(product, screenWidth);
              }).toList(),
            ),
          ),
          _buildCartSummary(screenWidth),
        ],
      ),
    );
  }
}