import 'package:flutter/material.dart';
import 'package:comission_shop/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // 1. Import Firestore

// --- Functional Input Helper ---
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

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _selectedUserType;
  final List<String> _userTypes = ['Seller', 'Admin', 'Buyer'];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // 2. Initialize Firestore

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (_formKey.currentState!.validate() && _selectedUserType != null) {
      try {
        // 3. Create User in Authentication
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Optional: Update Display Name
        await userCredential.user!.updateDisplayName(_nameController.text.trim());

        // 4. SAVE DATA TO FIRESTORE DATABASE
        // This creates a document in the 'users' collection with the same ID as the Auth User
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'role': _selectedUserType, // Saves 'Seller', 'Admin', or 'Buyer'
          'createdAt': DateTime.now(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful! Please log in.')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const login()),
        );

      } on FirebaseAuthException catch (e) {
        String message;
        if (e.code == 'weak-password') {
          message = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          message = 'An account already exists for that email.';
        } else if (e.code == 'invalid-email') {
          message = 'The email address is not valid.';
        } else {
          message = 'Registration failed. Error: ${e.message}';
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } else if (_selectedUserType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a User Type.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                const Icon(Icons.account_circle, color: Colors.amber, size: 120),
                const Text('Create Your Account',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)
                ),
                const SizedBox(height: 10),
                const Text('Register now to enjoy our services.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white70)),
                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    controller: _nameController,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                    decoration: _buildInputDecoration('Full Name', Icons.person),
                    validator: (value) => (value == null || value.isEmpty) ? 'Please enter your full name' : null,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                    decoration: _buildInputDecoration('Email', Icons.email),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter your email';
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Enter a valid email';
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                    decoration: _buildInputDecoration('Password', Icons.lock),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter a password';
                      if (value.length < 6) return 'Password must be at least 6 characters';
                      return null;
                    },
                  ),
                ),

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
                      style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Rubik Medium'),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? ', style: TextStyle(fontSize: 16, fontFamily: 'Rubik Regular', color: Colors.white70)),
                      const Text('Log In', style: TextStyle(fontSize: 16, fontFamily: 'Rubik Medium', color: Colors.amber))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}