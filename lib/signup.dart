import 'package:flutter/material.dart';
// Import the login page to navigate after signup
import 'package:comission_shop/login.dart';


// --- Functional Input Helper (Re-used for consistency) ---
InputDecoration _buildInputDecoration(String hintText, IconData icon, {IconData? suffixIcon, Color? iconColor}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(fontSize: 16, fontFamily: 'Rubik Regular', color: const Color(0xff4C5980).withOpacity(0.5)),
    fillColor: const Color(0xffF8F9FA),
    filled: true,
    prefixIcon: Icon(icon, color: iconColor ?? const Color(0xff323F4B)),
    suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: iconColor ?? const Color(0xff323F4B)) : null,
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffF9703B), width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffE4E7EB), width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffF9703B), width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    ),
  );
}
// ------------------------------------------------------------------

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _selectedUserType;
  final List<String> _userTypes = ['Seller', 'Admin', 'Buyer'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignup() {
    // --- Basic Validation ---
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _selectedUserType == null)
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields to sign up!')),
      );
      return;
    }

    // --- Signup Logic (Placeholder) ---
    print("User Signed Up:");
    print("Name: ${_nameController.text}");
    print("Email: ${_emailController.text}");
    print("User Type: $_selectedUserType");

    // 1. Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registration successful! Please log in.')),
    );

    // 2. Navigate to the login page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set dark background for consistency
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              // --- Header ---
              Icon(Icons.account_circle,color: Colors.amber,size: 120,),
              const Text('Create Your Account',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
              const SizedBox(height: 10),
              const Text('Register now to enjoy our services.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white70)),
              const SizedBox(height: 30),

              // --- Full Name Input ---
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _nameController,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                  decoration: _buildInputDecoration('Full Name', Icons.person),
                ),
              ),

              // --- Email Input ---
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                  decoration: _buildInputDecoration('Email', Icons.email),
                ),
              ),

              // --- Password Input ---
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                  decoration: _buildInputDecoration('Password', Icons.lock),
                ),
              ),

              // --- User Type Dropdown ---
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: DropdownButtonFormField<String>(
                  value: _selectedUserType,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                  decoration: _buildInputDecoration('User Type', Icons.group, iconColor: const Color(0xff323F4B)),
                  hint: Text('Select User Type', style: TextStyle(color: const Color(0xff4C5980).withOpacity(0.5))),
                  icon: const Icon(Icons.arrow_drop_down, color: Color(0xff323F4B)),
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedUserType = newValue;
                    });
                  },
                  items: _userTypes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 40),

              // --- Sign Up Button ---
              Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: MaterialButton(
                  onPressed: _handleSignup,
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rubik Medium'
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // --- Already Have an Account Link ---
              InkWell(
                onTap: () {
                  // Navigate back to login if they click this link
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? ',
                        style: TextStyle(fontSize: 16, fontFamily: 'Rubik Regular', color: Colors.white70)),
                    const Text('Log In',
                        style: TextStyle(fontSize: 16, fontFamily: 'Rubik Medium', color: Colors.amber))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}