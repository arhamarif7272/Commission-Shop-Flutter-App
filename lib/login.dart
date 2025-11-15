import 'package:comission_shop/signup.dart';
import 'package:flutter/material.dart';
import 'package:comission_shop/home.dart';
class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  // State variable to hold the currently selected user type
  String? _selectedUserType;

  // List of user types for the dropdown
  final List<String> _userTypes = ['Seller', 'Admin', 'Buyer'];


  // Helper function to build the common input decoration style
  InputDecoration _buildInputDecoration(String hintText, IconData icon, {IconData? suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      // Hint text is slightly light
      hintStyle: TextStyle(fontSize: 16, fontFamily: 'Rubik Regular', color: const Color(0xff4C5980).withOpacity(0.5)),
      // Fill color is kept light for contrast
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🎯 MODIFIED: Change Scaffold background color
      backgroundColor: Colors.blueGrey.shade900,
      body: SafeArea(
        child: Container(
          // 🎯 MODIFIED: Change inner Container color for a cohesive look
          color: Colors.blueGrey.shade900,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 50),
                // --- Logo Row ---
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Image(
                      height: 120,
                      width: 120,
                      image: AssetImage('logos.png',), // Ensure 'logo.png' is in your assets
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        // MODIFIED: Text color for better contrast on dark background
                        Text('Commission', style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold  ,fontFamily: 'Rubik Medium', color: Colors.amber)),
                        Text('Shop', style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold, fontFamily: 'Rubik Medium', color: Colors.amber)),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Icon(Icons.account_circle,color: Colors.amber,size: 120,),
                SizedBox(height: 10,),
                Text('LOGIN/SignUp', style: TextStyle(fontSize: 30 ,fontFamily: 'Rubik Medium', color: Colors.white)),
                const SizedBox(height: 5),


                // --- Email Input ---
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    style: TextStyle(fontSize: 16, fontFamily: 'Rubik Regular', color: const Color(0xff4C5980).withOpacity(0.5)),
                    decoration: _buildInputDecoration('Email', Icons.alternate_email_outlined),
                  ),
                ),

                // --- Password Input ---
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    style: TextStyle(fontSize: 16, fontFamily: 'Rubik Regular', color: const Color(0xff4C5980).withOpacity(0.5)),
                    obscureText: true,
                    decoration: _buildInputDecoration('Password', Icons.lock_open, suffixIcon: Icons.visibility_off_outlined),
                  ),
                ),

                // --- User Type Dropdown ---
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: DropdownButtonFormField<String>(
                    value: _selectedUserType,
                    style: TextStyle(fontSize: 16, fontFamily: 'Rubik Regular', color: const Color(0xff4C5980).withOpacity(0.9)),
                    decoration: _buildInputDecoration('User Type', Icons.group),
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

                // --- Forgot Password ---
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, 'emailVerification');
                          },
                          // MODIFIED: Text color for better contrast
                          child: const Text('Forgot Password?',
                              style: TextStyle(fontSize: 16, decoration: TextDecoration.underline, fontFamily: 'Rubik Regular', color: Colors.white)))),
                ),
SizedBox(width: 50,height: 5,),
                // --- Login Button ---
                Container(
                  height: 50,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      print('User Type Selected: $_selectedUserType');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const homeScreen()),
                      );
                    },
                    child: const Text('Login', style: TextStyle(color: Colors.black, fontFamily: 'Rubik Medium')),
                  ),
                ),

                // --- Sign Up Link ---
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    onTap: () {
                      print('click');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const signup()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // MODIFIED: Text color for better contrast
                        const Text('Don’t have an account? ', style: TextStyle(fontSize: 16, fontFamily: 'Rubik Regular', color: Colors.white70)),
                        const Text('Sign Up ', style: TextStyle(fontSize: 16, fontFamily: 'Rubik Medium', color: Colors.amber))
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}