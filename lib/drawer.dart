import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:comission_shop/login.dart'; // Access UserRoleManager

// Screen Imports
import 'package:comission_shop/home.dart';
import 'package:comission_shop/products.dart';
import 'package:comission_shop/payment.dart';
import 'package:comission_shop/contactus.dart';
import 'package:comission_shop/about.dart';
import 'package:comission_shop/sell.dart';
import 'package:comission_shop/revenue.dart';
import 'package:comission_shop/userinfo.dart';
import 'package:comission_shop/setting.dart';

class appdrawer extends StatelessWidget {
  const appdrawer({super.key});

  Widget _buildMenuItem(BuildContext context, String title, IconData icon, Widget page) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    UserRoleManager.currentRole = null;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const login()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final role = UserRoleManager.currentRole;

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.amber),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.account_circle, size: 50, color: Colors.black),
                  const SizedBox(height: 10),
                  Text(role ?? "Guest", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(context, "Home", Icons.home, const homeScreen()),

                // LOGIC: Conditional Menus
                if (role == 'Seller') ...[
                  _buildMenuItem(context, "Sell Listings", Icons.store, const sell()),
                ] else if (role == 'Admin') ...[
                  _buildMenuItem(context, "Revenue", Icons.monetization_on, const revenue()),
                  _buildMenuItem(context, "Manage Users", Icons.people, const userinfo()),
                ] else ...[
                  // Buyer or Guest
                  _buildMenuItem(context, "Products", Icons.shopping_cart, const PRODUCTS()),

                ],

                _buildMenuItem(context, "Shop Info", Icons.contact_phone, const contactus()),
                _buildMenuItem(context, "About Us", Icons.info, const about()),
                _buildMenuItem(context, "Settings", Icons.settings, const setting()),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton.icon(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout, color: Colors.black),
              label: const Text("Logout", style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            ),
          ),
        ],
      ),
    );
  }
}