import 'package:flutter/material.dart';
import 'package:comission_shop/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // DB Access
import 'package:firebase_auth/firebase_auth.dart'; // User Identity

// --- Functional Input Helper with Validation ---
Widget _buildFunctionalInputField({
  required String hint,
  required IconData icon,
  required TextEditingController controller,
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
          // Changed to TextFormField for validation
          child: TextFormField(
            controller: controller,
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
            // Validation Logic
            validator: (value) {
              if (value == null || value.isEmpty) return 'Required';
              return null;
            },
          ),
        ),
      ],
    ),
  );
}

class delivery extends StatefulWidget {
  // Accept the total amount passed from payment.dart
  final double totalAmount;

  const delivery({super.key, this.totalAmount = 0.0});

  @override
  State<delivery> createState() => _deliveryState();
}

class _deliveryState extends State<delivery> {
  // GlobalKey for Form Validation
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  Future<void> _submitDeliveryDetails() async {
    // 1. Validate Form
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields!')),
      );
      return;
    }

    try {
      // 2. Get Current User Info
      User? currentUser = FirebaseAuth.instance.currentUser;
      String userId = currentUser?.uid ?? 'guest';
      // Use form name if display name isn't set
      String userName = currentUser?.displayName ?? _nameController.text.trim();

      // 3. Save Transaction to Firestore
      await FirebaseFirestore.instance.collection('transactions').add({
        'type': 'Buy',
        'user': userName,
        'userId': userId,
        'product': 'Cart Order', // Generic name for bulk order
        'price': widget.totalAmount, // 🎯 Save actual revenue amount
        'address': "${_addressController.text}, ${_cityController.text} ${_zipCodeController.text}",
        'phone': _phoneController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // 4. Success Feedback
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Order confirmed! Data saved.'),
          backgroundColor: Colors.green,
        ),
      );

      // 5. Navigate Home after delay
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const homeScreen()),
              (Route<dynamic> route) => false,
        );
      });

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving order: $e"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Center(
          child: Text(
            "Delivery Details",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey, // Attach the form key
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            // 1. Order Total Display
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  const Text(
                    "Order Total",
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    "R\$ ${widget.totalAmount.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // 2. Form Input Container
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Contact Information",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const Divider(),

                  // Field 1: Name
                  _buildFunctionalInputField(
                    hint: "Full Name",
                    icon: Icons.person,
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                  ),

                  // Field 2: Phone
                  _buildFunctionalInputField(
                    hint: "Phone Number",
                    icon: Icons.phone,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    "Shipping Address",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const Divider(),

                  // Field 3: Address
                  _buildFunctionalInputField(
                    hint: "Street Address, House/Apt No.",
                    icon: Icons.location_on,
                    controller: _addressController,
                    keyboardType: TextInputType.streetAddress,
                  ),

                  // City and Zip Code Row Container
                  Row(
                    children: [
                      Expanded(
                        child: _buildFunctionalInputField(
                          hint: "City",
                          icon: Icons.location_city,
                          controller: _cityController,
                          keyboardType: TextInputType.text,
                          marginRight: 10,
                        ),
                      ),
                      Expanded(
                        child: _buildFunctionalInputField(
                          hint: "Zip Code",
                          icon: Icons.local_post_office,
                          controller: _zipCodeController,
                          keyboardType: TextInputType.number,
                          marginLeft: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 3. Submit Button Container
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: _submitDeliveryDetails,
                child: const Center(
                  child: Text(
                    "Confirm Delivery Details",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}