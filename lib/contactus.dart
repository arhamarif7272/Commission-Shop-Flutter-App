import 'package:comission_shop/drawer.dart';
import 'package:flutter/material.dart';

class contactus extends StatelessWidget {
  const contactus({super.key});

  // Helper function to build a contact detail section for a person/role
  Widget _buildStaffDetailContainer({
    required String role,
    required String name,
    required String phone,
    required String email,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.amber, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black, size: 30),
              const SizedBox(width: 10),
              Expanded( // Added Expanded to prevent overflow for long role names
                child: Text(
                  role,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const Divider(color: Colors.black54),
          // Name
          _buildInfoRow(Icons.person, "Name:", name),
          // Phone
          _buildInfoRow(Icons.phone, "Phone:", phone),
          // Email
          _buildInfoRow(Icons.email, "Email:", email),
        ],
      ),
    );
  }

  // Helper function for individual info rows
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to start for multi-line text
        children: [
          Icon(icon, size: 18, color: Colors.blueGrey.shade900),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade900,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black87,
              ),
              // Removed overflow: TextOverflow.ellipsis to allow wrapping if needed, or keep it based on preference
              // For addresses/descriptions, wrapping is usually better.
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Center(
          child: Text(
            "Shop Contacts & Staff",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
      drawer: const appdrawer(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          // 1. General Shop Contact Container 🏢
          Container(
            margin: const EdgeInsets.only(bottom: 25),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.amber, width: 3),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.store_outlined, color: Colors.blueGrey),
                    const SizedBox(width: 5),
                    Expanded( // Added Expanded to prevent overflow here
                      child: const Text(
                        "Commission Shop Head Office",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(color: Colors.amber),
                _buildInfoRow(
                  Icons.local_convenience_store_sharp,
                  "Shop Name:",
                  "Abdul Latif & Sons Commission Shop",
                ),
                _buildInfoRow(
                  Icons.phone_in_talk,
                  "Main Line:",
                  "(123) 456-7890",
                ),
                _buildInfoRow(
                  Icons.location_on,
                  "Address:",
                  "Green Market, Jaranwala",
                ),
                _buildInfoRow(
                  Icons.access_time,
                  "Hours:",
                  "Mon - Sun: 8:00 AM - 7:00 PM (Except:Fri)",
                ),
              ],
            ),
          ),

          // 2. Staff Details Header
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                Icon(Icons.group_outlined, color: Colors.white),
                SizedBox(width: 5),
                Expanded( // Added Expanded just in case
                  child: Text(
                    "Meet the Team",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. Shop Owner Details Container 👑
          _buildStaffDetailContainer(
            role: "Owner",
            name: "Arif Ali & Abdul Khaliq",
            phone: "+92 300 123 4567s",
            email: "abdul.latif@shop.com",
            color: Colors.amber.shade100,
            icon: Icons.star,
          ),

          // 4. Shop Clerk Details Container 👨‍💼
          _buildStaffDetailContainer(
            role: "Manager",
            name: "Liaqat Ali",
            phone: "+92 333 656 6543",
            email: "liaqat@shop.com",
            color: Colors.grey.shade300,
            icon: Icons.supervisor_account,
          ),
          _buildStaffDetailContainer(
            role: "Senior Clerk",
            name: "Muhammad Waqas",
            phone: "+92 333 987 5445",
            email: "muhammad.waqas@shop.com",
            color: Colors.grey.shade300,
            icon: Icons.supervisor_account,
          ),
          // 5. Additional Staff (Example)
          _buildStaffDetailContainer(
            role: "Logistics Coordinator",
            name: "Ashfaq",
            phone: "+92 345 112 2334",
            email: "ashfaq.logistics@shop.com",
            color: Colors.grey.shade300,
            icon: Icons.local_shipping,
          ),
        ],
      ),
    );
  }
}