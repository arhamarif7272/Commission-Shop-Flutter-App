import 'package:comission_shop/drawer.dart';
import 'package:flutter/material.dart';

class about extends StatelessWidget {
  const about({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Center(
          child: Text(
            "About Abdul Latif & Sons Commission Shop",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
      // Use ListView for a scrollable, clean layout
      drawer: appdrawer(),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: <Widget>[
          // 1. Mission Statement/Hero Container 🌟
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.amber.shade200,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Column(
              children: [
                Icon(Icons.business_center, color: Colors.black, size: 50),
                SizedBox(height: 10),
                Text(
                  "Our Mission: Quality First",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "We strive to be the most trusted commission shop, ensuring every product meets the highest standards of quality and service. Your satisfaction is our guarantee.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),

          // ---

          // 2. History Container 🕰️
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade800,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.work_history_outlined,color: Colors.white,),
                    SizedBox(width: 5,),
                    const Text(
                      "Our History",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(color: Colors.amber),
                const Text(
                  "Established in 2023, Abdul Latif Commission Shop has proudly served the community for decades. Starting as a small local venture, we have grown into a leading divisional supplier, built on the foundations of honesty and reliability.",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),

          // ---

          // 3. Team/Values Container (Using a Row of Containers) 🤝
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Our Core Values",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(color: Colors.blueGrey),
                // Row of Value Containers
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Value 1
                    _buildValueContainer(Icons.verified_user, "Integrity"),
                    // Value 2
                    _buildValueContainer(Icons.handshake, "Reliability"),
                    // Value 3
                    _buildValueContainer(Icons.support_agent, "Service"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget for Core Value Containers
  Widget _buildValueContainer(IconData icon, String label) {
    return Container(
      width: 100, // Fixed width for alignment
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber, width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.amber, size: 30),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}