import 'package:comission_shop/contactus.dart';
import 'package:flutter/material.dart';
import 'package:comission_shop/products.dart';
import 'package:comission_shop/about.dart';
import 'package:comission_shop/payment.dart';
import 'package:comission_shop/home.dart';
// 🎯 ASSUMING YOU HAVE A login.dart FILE
import 'package:comission_shop/login.dart';

class appdrawer extends StatelessWidget {
  const appdrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,

      // 🎯 Wrap ListView with Stack to allow absolute positioning of the button
      child: Stack(
        children: [
          // 1. Navigation List (The main content)
          ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.amber),
                child: const Center(
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_circle,
                        color: Colors.black,
                        size: 64.0,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "User",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const homeScreen()),
                  );
                },
                leading: const Icon(Icons.home),
                title: const Text(
                  "Home",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                iconColor: Colors.black,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PRODUCTS()),
                  );
                },
                leading: const Icon(Icons.production_quantity_limits),
                title: const Text(
                  "Products",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                iconColor: Colors.black,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const payment()),
                  );
                },
                leading: const Icon(Icons.payment),
                title: const Text(
                  "Payment",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                iconColor: Colors.black,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const contactus()),
                  );
                },
                leading: const Icon(Icons.contact_page),
                title: const Text(
                  "Contact Us",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                iconColor: Colors.black,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const about()),
                  );
                },
                leading: const Icon(Icons.add_business),
                title: const Text(
                  "About Us",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                iconColor: Colors.black,
              ),

              // Add enough empty space so the button doesn't cover the last ListTile
              const SizedBox(height: 70),
            ],
          ),

          // 2. 🎯 Login Button Positioned at the Bottom Right
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Close the drawer before pushing the new page
                  Navigator.pop(context);

                  // Push the login screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const login()),
                  );
                },
                icon: const Icon(Icons.login, color: Colors.black),
                label: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber, // Button color
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}