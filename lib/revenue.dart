import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math'; // Used to generate random dummy data for testing

class revenue extends StatelessWidget {
  const revenue({super.key});

  // --- Helper to Simulate Data (For Testing) ---
  // Since the Buy/Sell pages don't save to DB yet, this button helps you test the Revenue logic.
  Future<void> _addDummyTransaction() async {
    final List<String> products = ['Wheat', 'Rice', 'Corn', 'Sugar'];
    final List<String> users = ['Ali', 'Sara', 'Ahmed', 'Zainab'];
    final List<String> types = ['Buy', 'Sell'];
    final random = Random();

    String product = products[random.nextInt(products.length)];
    String user = users[random.nextInt(users.length)];
    String type = types[random.nextInt(types.length)];
    double price = (random.nextInt(500) + 50).toDouble(); // Random price 50-550

    await FirebaseFirestore.instance.collection('transactions').add({
      'user': user,
      'product': product,
      'price': price,
      'type': type,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        title: const Text("Revenue & Profit"),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_chart, color: Colors.black),
            tooltip: "Simulate Transaction",
            onPressed: _addDummyTransaction,
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('transactions')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text("Error loading data"));
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.amber));
          }

          final docs = snapshot.data!.docs;

          // --- CALCULATIONS ---
          double totalSales = 0.0;
          double totalCommission = 0.0;

          for (var doc in docs) {
            double price = (doc.data() as Map<String, dynamic>)['price']?.toDouble() ?? 0.0;
            totalSales += price;
            totalCommission += (price * 0.04); // 4% Commission
          }

          // Revenue Distribution
          double labourShare = totalCommission * 0.25; // 25% for Labour
          double netProfit = totalCommission * 0.75;   // 75% Profit

          return Column(
            children: [
              // 1. DASHBOARD HEADER
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade800,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const Text("Financial Overview", style: TextStyle(color: Colors.white70, fontSize: 16)),
                    const SizedBox(height: 10),

                    // Total Revenue Card
                    _buildSummaryCard("Total Commission Collected", totalCommission, Colors.amber),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(child: _buildSummaryCard("Labour (25%)", labourShare, Colors.orangeAccent)),
                        const SizedBox(width: 10),
                        Expanded(child: _buildSummaryCard("Net Profit (75%)", netProfit, Colors.greenAccent)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // 2. TRANSACTION LIST HEADER
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Recent Transactions",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // 3. TRANSACTION LIST
              Expanded(
                child: docs.isEmpty
                    ? const Center(child: Text("No transactions yet.", style: TextStyle(color: Colors.grey)))
                    : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var data = docs[index].data() as Map<String, dynamic>;
                    double price = data['price']?.toDouble() ?? 0.0;
                    double comm = price * 0.04;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: data['type'] == 'Sell' ? Colors.blue.shade100 : Colors.green.shade100,
                          child: Icon(
                            data['type'] == 'Sell' ? Icons.store : Icons.shopping_cart,
                            color: data['type'] == 'Sell' ? Colors.blue : Colors.green,
                          ),
                        ),
                        title: Text(
                          "${data['user']} ${data['type'] == 'Sell' ? 'Sold' : 'Bought'} ${data['product']}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Price: \$${price.toStringAsFixed(2)}"),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text("Comm (4%)", style: TextStyle(fontSize: 10, color: Colors.grey)),
                            Text(
                              "+\$${comm.toStringAsFixed(2)}",
                              style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard(String title, double amount, Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(
            "\$${amount.toStringAsFixed(2)}",
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}