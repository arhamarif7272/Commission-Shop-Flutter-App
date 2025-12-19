import 'package:comission_shop/anime.dart';
import 'package:comission_shop/appointments.dart';
import 'package:comission_shop/review.dart';
import 'package:comission_shop/viewrating.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import to get User details
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

import 'appointment_booking.dart';

class appdrawer extends StatelessWidget {
  const appdrawer({super.key});

  Widget _buildMenuItem(
      BuildContext context,
      String title,
      IconData icon,
      Widget page,
      ) {
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
    // 1. Get Current User and Role
    final User? user = FirebaseAuth.instance.currentUser;
    final String role = UserRoleManager.currentRole ?? "Guest";

    // 2. Get Name and Email (with fallbacks)
    final String displayName = user?.displayName ?? "Guest User";
    final String email = user?.email ?? "No Email";
    final String initial = displayName.isNotEmpty ? displayName[0].toUpperCase() : "G";

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // 3. Updated Drawer Header with Profile Details
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.amber),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar (First Letter)
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Text(
                    initial,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber, // Text color matches theme
                    ),
                  ),
                ),
                const SizedBox(width: 15),

                // Info Column (Name, Email, Role)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Text(
                        displayName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Email
                      Text(
                        email,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade800,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 6),

                      // Role Badge (Styled like the picture)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50, // Light blue background
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: Text(
                          role,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800, // Blue text
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(context, "Home", Icons.home, const homeScreen()),

                // LOGIC: Conditional Menus
                if (role == 'Seller') ...[
                  _buildMenuItem(
                    context,
                    "Sell Listings",
                    Icons.store,
                    const sell(),
                  ),
                  _buildMenuItem(
                    context,
                    "Appointment Booking",
                    Icons.calendar_month,
                    const appointment_booking(),
                  ),
                  _buildMenuItem(
                    context,
                    "Rate Us",
                    Icons.rate_review,
                    const review(),
                  ),
                ] else if (role == 'Admin') ...[
                  _buildMenuItem(
                    context,
                    "Revenue",
                    Icons.monetization_on,
                    const revenue(),
                  ),
                  _buildMenuItem(
                    context,
                    "Manage Users",
                    Icons.people,
                    const userinfo(),
                  ),
                  _buildMenuItem(
                    context,
                    "View Appointments",
                    Icons.schedule,
                    const appointments(),
                  ),
                  _buildMenuItem(
                    context,
                    "View Reviews",
                    Icons.reviews,
                    const view_rating(),
                  ),
                ] else ...[
                  // Buyer or Guest
                  _buildMenuItem(
                    context,
                    "Products",
                    Icons.shopping_cart,
                    const PRODUCTS(),
                  ),
                  _buildMenuItem(
                    context,
                    "Appointment Booking",
                    Icons.calendar_month,
                    const appointment_booking(),
                  ),
                  _buildMenuItem(
                    context,
                    "Rate Us",
                    Icons.rate_review,
                    const review(),
                  ),
                ],

                _buildMenuItem(
                  context,
                  "Shop Info",
                  Icons.contact_phone,
                  const contactus(),
                ),

                _buildMenuItem(context, "About Us", Icons.info, const about()),
                _buildMenuItem(
                  context,
                  "Settings",
                  Icons.settings,
                  const setting(),
                ),

                // _buildMenuItem(context, "Anime", Icons.animation, const anime()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton.icon(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout, color: Colors.black),
              label: const Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            ),
          ),
        ],
      ),
    );
  }
}