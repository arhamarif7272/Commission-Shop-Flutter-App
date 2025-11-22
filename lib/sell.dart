import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import for Database
import 'package:firebase_auth/firebase_auth.dart'; // Import for User ID

class sell extends StatefulWidget {
  const sell({super.key});

  @override
  State<sell> createState() => _sellState();
}

class _sellState extends State<sell> {
  // 1. Controllers for Product form fields
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _pricePerLbController = TextEditingController(); // NEW: Price Per LB
  final TextEditingController _totalPriceController = TextEditingController(); // Renamed for clarity

  // 2. Controllers for Bank Information
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _branchCodeController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _accountTitleController = TextEditingController();

  // Variable to simulate image selection state
  bool _isImageSelected = false;

  @override
  void initState() {
    super.initState();
    // Add listeners to auto-calculate total
    _quantityController.addListener(_calculateTotal);
    _pricePerLbController.addListener(_calculateTotal);
  }

  @override
  void dispose() {
    _quantityController.removeListener(_calculateTotal);
    _pricePerLbController.removeListener(_calculateTotal);

    _productNameController.dispose();
    _quantityController.dispose();
    _pricePerLbController.dispose();
    _totalPriceController.dispose();
    _bankNameController.dispose();
    _branchCodeController.dispose();
    _accountNumberController.dispose();
    _accountTitleController.dispose();
    super.dispose();
  }

  // Logic to calculate Total Price automatically
  void _calculateTotal() {
    double qty = double.tryParse(_quantityController.text) ?? 0;
    double rate = double.tryParse(_pricePerLbController.text) ?? 0;
    double total = qty * rate;

    // Update the total price field text
    _totalPriceController.text = total.toStringAsFixed(2);
  }

  // 3. Function to handle form submission
  Future<void> _submitListing() async {
    // Basic Validation
    if (_productNameController.text.isEmpty ||
        _quantityController.text.isEmpty ||
        _pricePerLbController.text.isEmpty ||
        _bankNameController.text.isEmpty ||
        _branchCodeController.text.isEmpty ||
        _accountNumberController.text.isEmpty ||
        _accountTitleController.text.isEmpty ||
        !_isImageSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all product and bank details.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Get Current User Info
      User? currentUser = FirebaseAuth.instance.currentUser;
      String userName = currentUser?.displayName ?? currentUser?.email ?? "Unknown Seller";

      // Save to Firestore
      await FirebaseFirestore.instance.collection('transactions').add({
        'type': 'Sell',
        'user': userName,
        'product': _productNameController.text.trim(),
        'quantity': double.tryParse(_quantityController.text) ?? 0,
        'price_per_lb': double.tryParse(_pricePerLbController.text) ?? 0,
        'price': double.tryParse(_totalPriceController.text) ?? 0, // Total Price for Revenue Calc
        'bank_name': _bankNameController.text.trim(),
        'account_number': _accountNumberController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Success Message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Success! Listed: ${_productNameController.text} for Total: \$${_totalPriceController.text}',
          ),
          backgroundColor: Colors.green,
        ),
      );

      // Clear the form
      _productNameController.clear();
      _quantityController.clear();
      _pricePerLbController.clear();
      _totalPriceController.clear();
      _bankNameController.clear();
      _branchCodeController.clear();
      _accountNumberController.clear();
      _accountTitleController.clear();

      setState(() {
        _isImageSelected = false;
      });

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving listing: $e'), backgroundColor: Colors.red),
      );
    }
  }

  // Helper Widget to build styled text fields
  Widget _buildInputField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    TextInputType type = TextInputType.text,
    bool isReadOnly = false, // Added option for read-only fields
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: isReadOnly ? Colors.grey.shade200 : Colors.white, // Visual cue for read-only
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        keyboardType: type,
        readOnly: isReadOnly,
        decoration: InputDecoration(
          icon: Icon(icon, color: Colors.blueGrey),
          border: InputBorder.none,
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey.shade600),
        ),
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
            "Sell New Product",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Header / Instructions Container
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.amber),
            ),
            child: Row(
              children: const [
                Icon(Icons.storefront, size: 40, color: Colors.black),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    "List your products and provide bank details for payouts.",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Main Form Container - Product Info
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Product Information",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const Divider(),

                // 1. Product Name Input
                _buildInputField(
                  label: "Product Name (e.g., Wheat, Rice)",
                  icon: Icons.label,
                  controller: _productNameController,
                ),

                // 2. Quantity Input
                _buildInputField(
                  label: "Quantity (lb)",
                  icon: Icons.scale,
                  controller: _quantityController,
                  type: TextInputType.number,
                ),

                // 3. NEW: Price Per LB Input
                _buildInputField(
                  label: "Price per lb (\$)",
                  icon: Icons.price_change,
                  controller: _pricePerLbController,
                  type: TextInputType.number,
                ),

                // 4. Auto-Calculated Total Price (Read Only)
                _buildInputField(
                  label: "Total Amount (Auto-calculated)",
                  icon: Icons.attach_money,
                  controller: _totalPriceController,
                  isReadOnly: true, // User cannot edit this manually
                ),

                const SizedBox(height: 20),
                const Text(
                  "Product Image",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 10),

                // 5. Custom Image Picker UI
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isImageSelected = !_isImageSelected;
                    });
                  },
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _isImageSelected ? Colors.green.shade50 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _isImageSelected ? Colors.green : Colors.grey.shade400,
                        width: 2,
                        style: _isImageSelected ? BorderStyle.solid : BorderStyle.solid,
                      ),
                    ),
                    child: _isImageSelected
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.check_circle, size: 50, color: Colors.green),
                        SizedBox(height: 10),
                        Text("Image Uploaded Successfully", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ],
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.cloud_upload_outlined, size: 40, color: Colors.grey),
                        SizedBox(height: 10),
                        Text("Tap to Upload Image", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Bank Account Information Container
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Bank Account Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const Divider(),

                // Bank Name
                _buildInputField(
                  label: "Bank Name",
                  icon: Icons.account_balance,
                  controller: _bankNameController,
                ),

                // Branch Code
                _buildInputField(
                  label: "Branch Code",
                  icon: Icons.pin,
                  controller: _branchCodeController,
                  type: TextInputType.number,
                ),

                // Account Title
                _buildInputField(
                  label: "Account Title",
                  icon: Icons.person,
                  controller: _accountTitleController,
                ),

                // Account Number
                _buildInputField(
                  label: "Account Number / IBAN",
                  icon: Icons.numbers,
                  controller: _accountNumberController,
                  type: TextInputType.number,
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // 4. Submit Button Container
          Container(
            height: 55,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: InkWell(
              onTap: _submitListing,
              child: const Center(
                child: Text(
                  "Submit Listing",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
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