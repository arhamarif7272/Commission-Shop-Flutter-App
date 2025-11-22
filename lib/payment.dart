import 'package:comission_shop/drawer.dart';
import 'package:flutter/material.dart';
import 'package:comission_shop/delivery.dart';

class payment extends StatefulWidget {
  // Accept the total amount from Products page
  final double totalAmount;
  const payment({super.key, this.totalAmount = 0.0});

  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  String _selectedPaymentMethod = 'Card';

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _nameController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  Widget _buildPaymentOptionContainer({required IconData icon, required String label, required bool isSelected}) {
    return InkWell(
      onTap: () => setState(() => _selectedPaymentMethod = label),
      child: Container(
        width: 120, padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(color: isSelected ? Colors.amber : Colors.blueGrey.shade700, borderRadius: BorderRadius.circular(8), border: isSelected ? Border.all(color: Colors.black, width: 2) : null),
        child: Column(children: [Icon(icon, color: isSelected ? Colors.black : Colors.white, size: 30), const SizedBox(height: 5), Text(label, style: TextStyle(color: isSelected ? Colors.black : Colors.white, fontWeight: FontWeight.bold))]),
      ),
    );
  }

  // Updated to use TextFormField for validation
  Widget _buildFunctionalInputField({
    required String hint, required IconData icon, required TextInputType keyboardType, required TextEditingController controller,
    double marginLeft = 0, double marginRight = 0, bool isObscured = false, int minLength = 1
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(marginLeft, 10, marginRight, 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300, width: 1.5), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: isObscured,
              cursorColor: Colors.amber,
              decoration: InputDecoration(hintText: hint, hintStyle: TextStyle(color: Colors.grey.shade500), border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(vertical: 10)),
              style: const TextStyle(color: Colors.black),
              // VALIDATION LOGIC
              validator: (value) {
                if (value == null || value.isEmpty) return 'Required';
                if (value.length < minLength) return 'Invalid';
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  void _proceedToDelivery() {
    // Only validate if Card is selected
    if (_selectedPaymentMethod == 'Card') {
      if (!_formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fix errors in card details')));
        return;
      }
    }
    // Navigate and pass total amount
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => delivery(totalAmount: widget.totalAmount),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(backgroundColor: Colors.amber, title: const Center(child: Text("Payment Details", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24)))),
      drawer: const appdrawer(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 20), padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(15)),
            child: Center(child: Text("Total to Pay: R\$ ${widget.totalAmount.toStringAsFixed(2)}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.black))),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20), padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.blueGrey.shade800, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Select Payment Method:", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [_buildPaymentOptionContainer(icon: Icons.credit_card, label: "Card", isSelected: _selectedPaymentMethod == 'Card'), _buildPaymentOptionContainer(icon: Icons.money, label: "Cash", isSelected: _selectedPaymentMethod == 'Cash')]),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10)]),
            child: _selectedPaymentMethod == 'Card'
                ? Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text("Card Information", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const Divider(),
                  _buildFunctionalInputField(hint: "Card Number", icon: Icons.dialpad, keyboardType: TextInputType.number, controller: _cardNumberController, minLength: 12),
                  _buildFunctionalInputField(hint: "Cardholder Name", icon: Icons.person, keyboardType: TextInputType.text, controller: _nameController, minLength: 3),
                  Row(children: [Expanded(child: _buildFunctionalInputField(hint: "MM/YY", icon: Icons.calendar_today, keyboardType: TextInputType.datetime, marginRight: 10, controller: _expiryController, minLength: 4)), Expanded(child: _buildFunctionalInputField(hint: "CVV", icon: Icons.lock, keyboardType: TextInputType.number, marginLeft: 10, isObscured: true, controller: _cvvController, minLength: 3))]),
                ],
              ),
            )
                : const Center(child: Column(children: [Icon(Icons.money_off, size: 60, color: Colors.green), SizedBox(height: 10), Text("Pay with Cash on Delivery", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)), SizedBox(height: 5), Text("Please have the exact change ready upon delivery.", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.black54))])),
          ),
          const SizedBox(height: 30),
          Container(
            height: 60, decoration: BoxDecoration(color: Colors.green.shade600, borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: _proceedToDelivery,
              child: const Center(child: Text("Confirm Order & Enter Delivery Details", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
            ),
          ),
        ],
      ),
    );
  }
}