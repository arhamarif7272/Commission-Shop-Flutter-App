// import 'package:comission_shop/drawer.dart';
// import 'package:flutter/material.dart';
// import 'package:comission_shop/products.dart';
// import 'package:comission_shop/login.dart'; // Import to access UserRoleManager
//
// class homeScreen extends StatelessWidget {
//   const homeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Determine the screen width for responsive design (Container-based)
//     final double screenWidth = MediaQuery.of(context).size.width;
//
//     // Get the current user role
//     final String? userRole = UserRoleManager.currentRole;
//
//     return Scaffold(
//       backgroundColor: Colors.blueGrey.shade900,
//       appBar: AppBar(
//         backgroundColor: Colors.amber,
//         title: Center(
//           child: const Text(
//             "Abdul Latif & Sons Commission Shop",
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),
//         ),
//       ),
//
//       drawer: const appdrawer(),
//       body: ListView(
//         children: <Widget>[
//           // 1. **Hero Section Container** 🦸‍♂️
//           Container(
//             height: 350,
//             width: screenWidth,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('hero.png'),
//                 fit: BoxFit.fitWidth,
//                 colorFilter: ColorFilter.mode(
//                   Colors.black.withOpacity(0.1),
//                   BlendMode.darken,
//                 ),
//               ),
//             ),
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   const Text(
//                     "Commission Shop Excellence",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 32,
//                       fontWeight: FontWeight.w900,
//                       shadows: [Shadow(color: Colors.black, blurRadius: 4)],
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     "Your trusted source for quality products and service.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.amber,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       shadows: [Shadow(color: Colors.black, blurRadius: 3)],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//
//                   // --- CONDITIONAL BUTTON RENDERING ---
//                   // Only show if the user is a 'Buyer' or 'Guest' (null)
//                   if (userRole == 'Buyer' || userRole == null)
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.amber,
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: FloatingActionButton.extended(
//                         onPressed: () {
//                           // Navigate to Products page on tap
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const PRODUCTS(),
//                             ),
//                           );
//                         },
//                         label: const Text(
//                           "View Our Products",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                         icon: const Icon(Icons.store, color: Colors.black),
//                         backgroundColor: Colors.transparent,
//                         elevation: 0,
//                       ),
//                     ),
//                   // ------------------------------------
//                 ],
//               ),
//             ),
//           ),
//
//           // ---
//
//           // 2. **Featured Section Container** ✨
//           Container(
//             padding: const EdgeInsets.all(20),
//             color: Colors.blueGrey.shade800,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 const Text(
//                   "Why Choose Us?",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 // Features as Containers inside a Row
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     // Feature 1
//                     Container(
//                       width: screenWidth / 3 - 30,
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: Colors.white10,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         children: <Widget>[
//                           const Icon(
//                             Icons.verified,
//                             color: Colors.amber,
//                             size: 40,
//                           ),
//                           const SizedBox(height: 5),
//                           const Text(
//                             "Certified Quality",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Feature 2
//                     Container(
//                       width: screenWidth / 3 - 30,
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: Colors.white10,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         children: <Widget>[
//                           const Icon(
//                             Icons.local_shipping,
//                             color: Colors.amber,
//                             size: 40,
//                           ),
//                           const SizedBox(height: 5),
//                           const Text(
//                             "Fast Delivery",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Feature 3
//                     Container(
//                       width: screenWidth / 3 - 30,
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: Colors.white10,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         children: <Widget>[
//                           const Icon(
//                             Icons.support_agent,
//                             color: Colors.amber,
//                             size: 40,
//                           ),
//                           const SizedBox(height: 5),
//                           const Text(
//                             "24/7 Support",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//
//           // ---
//
//           // 3. **Image Gallery/Promo Container** 🖼️
//           Container(
//             padding: const EdgeInsets.all(20),
//             color: Colors.blueGrey.shade900,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 // Increased font size for the title
//                 const Text(
//                   "Latest Arrivals",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 20), // Increased spacing
//                 // Simple image gallery using a Row of Containers
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     // Product Image 1
//                     Container(
//                       width: 300,
//                       height: 250,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: Colors.amber, width: 3),
//                         image: DecorationImage(
//                           image: AssetImage('gurr2.jpg'),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: 300,
//                       height: 250,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: Colors.amber, width: 3),
//                         image: DecorationImage(
//                           image: AssetImage('rice.jpg'),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: 300,
//                       height: 250,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: Colors.amber, width: 3),
//                         image: DecorationImage(
//                           image: AssetImage('canola.jpg'),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     // Product Image 2
//                     Container(
//                       width: 300,
//                       height: 250,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: Colors.amber, width: 3),
//                         image: DecorationImage(
//                           image: AssetImage('wheat.jpg'),
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:comission_shop/drawer.dart';
import 'package:flutter/material.dart';
import 'package:comission_shop/products.dart';
import 'package:comission_shop/login.dart'; // Import to access UserRoleManager

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine the screen width for responsive design (Container-based)
    final double screenWidth = MediaQuery.of(context).size.width;

    // Get the current user role
    final String? userRole = UserRoleManager.currentRole;

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Center(
          child: const Text(
            "Abdul Latif & Sons Commission Shop",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),

      drawer: const appdrawer(),
      body: ListView(
        children: <Widget>[
          // 1. **Hero Section Container** 🦸‍♂️
          Container(
            height: 350,
            width: screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('hero.png'),
                fit: BoxFit.fitWidth,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Commission Shop Excellence",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Your trusted source for quality products and service.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      shadows: [Shadow(color: Colors.black, blurRadius: 3)],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- CONDITIONAL BUTTON RENDERING ---
                  // Only show if the user is a 'Buyer' or 'Guest' (null)
                  if (userRole == 'Buyer' || userRole == null)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          // Navigate to Products page on tap
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PRODUCTS(),
                            ),
                          );
                        },
                        label: const Text(
                          "View Our Products",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        icon: const Icon(Icons.store, color: Colors.black),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    ),
                  // ------------------------------------
                ],
              ),
            ),
          ),

          // ---

          // 2. **Featured Section Container** ✨
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.blueGrey.shade800,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Why Choose Us?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                // Features as Containers inside a Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // Feature 1
                    Container(
                      width: screenWidth / 3 - 30,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: <Widget>[
                          const Icon(
                            Icons.verified,
                            color: Colors.amber,
                            size: 40,
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Certified Quality",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Feature 2
                    Container(
                      width: screenWidth / 3 - 30,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: <Widget>[
                          const Icon(
                            Icons.local_shipping,
                            color: Colors.amber,
                            size: 40,
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Fast Delivery",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Feature 3
                    Container(
                      width: screenWidth / 3 - 30,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: <Widget>[
                          const Icon(
                            Icons.support_agent,
                            color: Colors.amber,
                            size: 40,
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "24/7 Support",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ---

          // 3. **Image Gallery/Promo Container** 🖼️
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.blueGrey.shade900,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Increased font size for the title
                const Text(
                  "Latest Arrivals",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20), // Increased spacing
                // Simple image gallery using a Row of Containers
                // Added SingleChildScrollView to fix overflow
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      // Product Image 1
                      Container(
                        width: 300,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.amber, width: 3),
                          image: DecorationImage(
                            image: AssetImage('gurr2.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15), // Add spacing
                      Container(
                        width: 300,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.amber, width: 3),
                          image: DecorationImage(
                            image: AssetImage('rice.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15), // Add spacing
                      Container(
                        width: 300,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.amber, width: 3),
                          image: DecorationImage(
                            image: AssetImage('canola.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15), // Add spacing
                      // Product Image 2
                      Container(
                        width: 300,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.amber, width: 3),
                          image: DecorationImage(
                            image: AssetImage('wheat.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}