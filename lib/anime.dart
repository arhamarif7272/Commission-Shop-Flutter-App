import 'package:flutter/material.dart';
import 'package:comission_shop/home.dart'; // To navigate after animation

class anime extends StatefulWidget {
  const anime({super.key});

  @override
  State<anime> createState() => _animeState();
}

class _animeState extends State<anime> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // 1. Initialize Animation Controller (Duration: 2 seconds)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // 2. Define Scale Animation (Grow with bounce)
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut, // Bouncy effect
      ),
    );

    // 3. Define Opacity Animation (Fade in)
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    // 4. Define Slide Animation (Text moves up)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 2), // Start below screen
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        title: const Text("Status"),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --- Animated Icon Container ---
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: const Icon(
                  Icons.check_circle,
                  size: 80,
                  color: Colors.green,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // --- Animated Text ---
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: Column(
                  children: [
                    const Text(
                      "Successfull",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Your process is completed!",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 50),

                    // Button to go back Home
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const homeScreen())
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      child: const Text(
                        "Go to Home",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
//
// void main() => runApp(const MaterialApp(home: SimpleAnimation()));
//
// class SimpleAnimation extends StatefulWidget {
//   const SimpleAnimation({super.key});
//
//   @override
//   State<SimpleAnimation> createState() => _SimpleAnimationState();
// }
//
// class _SimpleAnimationState extends State<SimpleAnimation> {
//   // 1. Define the initial state variables
//   double _size = 100.0;
//   Color _color = Colors.blue;
//   double _radius = 8.0;
//
//   void _animate() {
//     setState(() {
//       // 2. Change the values inside setState
//       _size = _size == 100.0 ? 200.0 : 100.0;
//       _color = _color == Colors.blue ? Colors.red : Colors.blue;
//       _radius = _radius == 8.0 ? 50.0 : 8.0;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: AnimatedContainer(
//           // 3. Set the duration (how long the animation lasts)
//           duration: const Duration(milliseconds: 500),
//           // 4. Choose a curve (bounce, easeIn, etc.)
//           curve: Curves.easeInOut,
//           width: _size,
//           height: _size,
//           decoration: BoxDecoration(
//             color: _color,
//             borderRadius: BorderRadius.circular(_radius),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _animate,
//         child: const Icon(Icons.play_arrow),
//       ),
//     );
//   }
// }