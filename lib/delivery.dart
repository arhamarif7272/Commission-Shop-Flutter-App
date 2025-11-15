import 'package:flutter/material.dart';
import 'package:comission_shop/home.dart';

// --- Functional Input Helper (Re-used for consistency) ---
Widget _buildFunctionalInputField({
  required String hint,
  required IconData icon,
  required TextEditingController controller, // Now requires a controller
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
          // Functional TextField
          child: TextField(
            controller: controller, // Linked controller
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
// ------------------------------------------------------------------

class delivery extends StatefulWidget {
  const delivery({super.key});

  @override
  State<delivery> createState() => _deliveryState();
}

class _deliveryState extends State<delivery> {
  // 1. Controllers for managing the state of the input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  // Dispose controllers when the widget is removed
  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  // Function to handle form submission
  void _submitDeliveryDetails() {
    // Basic validation check (just ensures the name field is not empty)
    if (_nameController.text.isEmpty || _addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in Name and Address!')),
      );
      return;
    }

    // Capture and print the data (In a real app, this would be saved to a database)
    print("--- Delivery Details Submitted ---");
    print("Name: ${_nameController.text}");
    print("Phone: ${_phoneController.text}");
    print("Address: ${_addressController.text}");
    print("City: ${_cityController.text}");
    print("Zip: ${_zipCodeController.text}");
    print("--------------------------------");


    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Delivery details submitted successfully!')),
    );


    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const homeScreen()),
            (Route<dynamic> route) => false, // This predicate ensures ALL previous routes are removed
      );
    });
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
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          // 1. Header Container
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.green.shade600,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: Text(
                "Where should we deliver?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
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
                      // Field 4: City
                      child: _buildFunctionalInputField(
                        hint: "City",
                        icon: Icons.location_city,
                        controller: _cityController,
                        keyboardType: TextInputType.text,
                        marginRight: 10,
                      ),
                    ),
                    Expanded(
                      // Field 5: Zip Code
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

          // 3. Submit Button Container (Now calls the submission function)
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: _submitDeliveryDetails, // Call the submission function
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
    );
  }
}