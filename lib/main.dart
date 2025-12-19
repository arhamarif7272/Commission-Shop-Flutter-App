// import 'package:comission_shop/anime.dart';
// import 'package:flutter/material.dart';
// // Note: We removed Firebase init from here to prevent white screen hang.
//
// // Import all application screens
// import 'package:comission_shop/login.dart';
// import 'package:comission_shop/signup.dart';
// import 'package:comission_shop/home.dart';
// import 'package:comission_shop/products.dart';
// import 'package:comission_shop/payment.dart';
// import 'package:comission_shop/contactus.dart';
// import 'package:comission_shop/delivery.dart';
// import 'package:comission_shop/about.dart';
// import 'package:comission_shop/sell.dart';
// import 'package:comission_shop/revenue.dart';
// import 'package:comission_shop/userinfo.dart';
// import 'package:comission_shop/splash_screen.dart'; // Import Splash
// import 'package:comission_shop/setting.dart';
//
// void main() {
//   // 1. Initialize Bindings only
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // 2. Run App Immediately (Fixes White Screen)
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Abdul Latif Commission Shop',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.amber,
//         scaffoldBackgroundColor: Colors.blueGrey.shade900,
//         useMaterial3: true,
//       ),
//
//       // Start with Splash Screen
//       initialRoute: '/splash',
//
//       routes: {
//         '/splash': (context) => const SplashScreen(),
//         '/': (context) => const login(),
//         '/signup': (context) => const signup(),
//         '/home': (context) => const homeScreen(),
//         '/products': (context) => const PRODUCTS(),
//         '/payment': (context) => const payment(),
//         '/contactus': (context) => const contactus(),
//         '/contact': (context) => const delivery(),
//         '/about': (context) => const about(),
//         '/sell': (context) => const sell(),
//         '/revenue': (context) => const revenue(),
//         '/userinfo': (context) => const userinfo(),
//         '/setting': (context) => const setting(),
//         '/anime': (context) => const anime(),
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:device_preview/device_preview.dart'; // 1. Import Package

// Import all application screens
import 'package:comission_shop/login.dart';
import 'package:comission_shop/signup.dart';
import 'package:comission_shop/home.dart';
import 'package:comission_shop/products.dart';
import 'package:comission_shop/payment.dart';
import 'package:comission_shop/contactus.dart';
import 'package:comission_shop/delivery.dart';
import 'package:comission_shop/about.dart';
import 'package:comission_shop/sell.dart';
import 'package:comission_shop/revenue.dart';
import 'package:comission_shop/userinfo.dart';
import 'package:comission_shop/splash_screen.dart';
import 'package:comission_shop/setting.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 2. Wrap MyApp inside DevicePreview
  runApp(
    DevicePreview(
      enabled: true, // Isko true rakhne se mobile frame show hoga
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abdul Latif Commission Shop',
      debugShowCheckedModeBanner: false,

      // 3. Add these 3 lines for DevicePreview to work
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.blueGrey.shade900,
        useMaterial3: true,
      ),

      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/': (context) => const login(),
        '/signup': (context) => const signup(),
        '/home': (context) => const homeScreen(),
        '/products': (context) => const PRODUCTS(),
        '/payment': (context) => const payment(),
        '/contactus': (context) => const contactus(),
        '/contact': (context) => const delivery(),
        '/about': (context) => const about(),
        '/sell': (context) => const sell(),
        '/revenue': (context) => const revenue(),
        '/userinfo': (context) => const userinfo(),
        '/setting': (context) => const setting(),
      },
    );
  }
}