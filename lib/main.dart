import 'package:comission_shop/delivery.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Ensure this file exists from FlutterFire CLI

// Import all application screens
import 'package:comission_shop/login.dart';
import 'package:comission_shop/signup.dart';
import 'package:comission_shop/home.dart';
import 'package:comission_shop/products.dart';
import 'package:comission_shop/payment.dart';
import 'package:comission_shop/contactus.dart'; // Shop Info
import 'package:comission_shop/delivery.dart';   // Delivery Form
import 'package:comission_shop/about.dart';
import 'package:comission_shop/sell.dart';
import 'package:comission_shop/revenue.dart';
import 'package:comission_shop/userinfo.dart';
import 'package:comission_shop/setting.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abdul Latif Commission Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.blueGrey.shade900,
        useMaterial3: true,
      ),

      // Start at Login
      initialRoute: '/',
      routes: {
        '/': (context) => const login(),
        '/signup': (context) => const signup(),
        '/home': (context) => const homeScreen(),
        '/products': (context) => const PRODUCTS(),
        '/payment': (context) => const payment(),
        '/contactus': (context) => const contactus(), // Shop Info
        '/delivery': (context) => const delivery(),     // Delivery Form
        '/about': (context) => const about(),
        '/sell': (context) => const sell(),
        '/revenue': (context) => const revenue(),
        '/userinfo': (context) => const userinfo(),
        '/setting': (context) => const setting(),
      },
    );
  }
}