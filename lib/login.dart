import 'package:comission_shop/signup.dart';
import 'package:flutter/material.dart';
import 'package:comission_shop/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Global class to hold the user's role after login
class UserRoleManager {
  static String? currentRole;
}

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _selectedUserType;
  final List<String> _userTypes = ['Seller', 'Admin', 'Buyer'];

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration(String hintText, IconData icon, {IconData? suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(fontSize: 16, fontFamily: 'Rubik Regular', color: const Color(0xff4C5980).withOpacity(0.5)),
      fillColor: const Color(0xffF8F9FA),
      filled: true,
      prefixIcon: Icon(icon, color: const Color(0xff323F4B)),
      suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: const Color(0xff323F4B)) : null,
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

  Future<void> _login() async {
    if (_formKey.currentState!.validate() && _selectedUserType != null) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // SAVE ROLE GLOBALLY
        UserRoleManager.currentRole = _selectedUserType;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Welcome $_selectedUserType! Logging in...')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const homeScreen()),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Login Failed')),
        );
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
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            color: Colors.blueGrey.shade900,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  const SizedBox(height: 50),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        height: 120,
                        width: 120,
                        image: AssetImage('logos.png'),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Commission', style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold, fontFamily: 'Rubik Medium', color: Colors.amber)),
                          Text('Shop', style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold, fontFamily: 'Rubik Medium', color: Colors.amber)),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Icon(Icons.account_circle,color: Colors.amber,size: 120),
                  const SizedBox(height: 10),
                  Center(child: const Text('LOGIN', style: TextStyle(fontSize: 30 ,fontFamily: 'Rubik Medium', color: Colors.amber,fontWeight: FontWeight.bold))),
                  const SizedBox(height: 5),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _buildInputDecoration('Email', Icons.alternate_email_outlined),
                      validator: (value) => (value == null || value.isEmpty) ? 'Enter email' : null,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: _buildInputDecoration('Password', Icons.lock_open, suffixIcon: Icons.visibility_off_outlined),
                      validator: (value) => (value == null || value.length < 6) ? 'Password too short' : null,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: DropdownButtonFormField<String>(
                      value: _selectedUserType,
                      decoration: _buildInputDecoration('User Type', Icons.group),
                      hint: const Text('Select User Type'),
                      items: _userTypes.map((String value) {
                        return DropdownMenuItem<String>(value: value, child: Text(value));
                      }).toList(),
                      onChanged: (newValue) => setState(() => _selectedUserType = newValue),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: MaterialButton(
                      onPressed: _login,
                      child: const Text('Login', style: TextStyle(color: Colors.black, fontFamily: 'Rubik Medium')),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const signup())),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Don’t have an account? ', style: TextStyle(fontSize: 16, color: Colors.white70)),
                          Text('Sign Up ', style: TextStyle(fontSize: 16, color: Colors.amber, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}