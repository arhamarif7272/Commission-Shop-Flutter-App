import 'package:comission_shop/drawer.dart';
import 'package:flutter/material.dart';
import 'package:comission_shop/delivery.dart';

class payment extends StatefulWidget {
  const payment({super.key});

  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  // State variable to track the selected payment method
  String _selectedPaymentMethod = 'Card'; // Default to Card

  // --- Helper Widgets (Unchanged) ---

  // Helper to build Payment Option Tabs (Now handles the tap action)
  Widget _buildPaymentOptionContainer({
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        // Update the state when tapped
        setState(() {
          _selectedPaymentMethod = label;
        });
      },
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 10),
        // Color changes based on the state variable
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber : Colors.blueGrey.shade700,
          borderRadius: BorderRadius.circular(8),
          border: isSelected ? Border.all(color: Colors.black, width: 2) : null,
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? Colors.black : Colors.white, size: 30),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to create a functional TextField wrapped in a Container (Unchanged)
  Widget _buildFunctionalInputField({
    required String hint,
    required IconData icon,
    required TextInputType keyboardType,
    double marginLeft = 0,
    double marginRight = 0,
    bool isObscured = false,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(marginLeft, 10, marginRight, 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              keyboardType: keyboardType,
              obscureText: isObscured,
              cursorColor: Colors.amber,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey.shade500),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine the screen width for responsive design (Container-based)
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Center(
          child: Text(
            "Payment Details",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
      drawer: appdrawer(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          // 1. Payment Header Container 💳
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: Text(
                "Secure Checkout",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // 2. Payment Options Container
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade800,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select Payment Method:",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // Row of Containers for options (Now functional)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Option 1: Card
                    _buildPaymentOptionContainer(
                      icon: Icons.credit_card,
                      label: "Card",
                      // Check if 'Card' is the selected method
                      isSelected: _selectedPaymentMethod == 'Card',
                    ),
                    // Option 2: Cash on Delivery
                    _buildPaymentOptionContainer(
                      icon: Icons.money,
                      label: "Cash",
                      // Check if 'Cash' is the selected method
                      isSelected: _selectedPaymentMethod == 'Cash',
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 3. Conditional Content Container
          // Display Card form OR Cash message based on selection
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                ),
              ],
            ),
            child: _selectedPaymentMethod == 'Card'
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Card Information",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const Divider(),
                _buildFunctionalInputField(
                  hint: "Card Number",
                  icon: Icons.dialpad,
                  keyboardType: TextInputType.number,
                ),
                _buildFunctionalInputField(
                  hint: "Cardholder Name",
                  icon: Icons.person,
                  keyboardType: TextInputType.text,
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildFunctionalInputField(
                        hint: "MM/YY",
                        icon: Icons.calendar_today,
                        keyboardType: TextInputType.datetime,
                        marginRight: 10,
                      ),
                    ),
                    Expanded(
                      child: _buildFunctionalInputField(
                        hint: "CVV",
                        icon: Icons.lock,
                        keyboardType: TextInputType.number,
                        marginLeft: 10,
                        isObscured: true,
                      ),
                    ),
                  ],
                ),
              ],
            )
                : const Center(
              child: Column(
                children: [
                  Icon(Icons.money_off, size: 60, color: Colors.green),
                  SizedBox(height: 10),
                  Text(
                    "Pay with Cash on Delivery",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Please have the exact change ready upon delivery.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          // 4. Pay Button Container (UPDATED)
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.green.shade600,
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                // Navigate to the Delivery Details (contact) page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const delivery(),
                  ),
                );
              },
              child: const Center(
                child: Text(
                  "Confirm Order & Enter Delivery Details", // Updated text for clarity
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18, // Reduced font size slightly to fit long text
                    fontWeight: FontWeight.bold,
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