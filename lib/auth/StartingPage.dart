import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -screenHeight * 0.05,
            right: -screenWidth * 0.16,
            child: SizedBox(
              height: screenHeight * 0.6,
              width: screenWidth * 1.25,
              child: Lottie.asset("asset/animation/Animation - 1.json"),
            ),
          ),
          Positioned(
            bottom: -screenWidth / 2,
            right: -screenWidth * 0.375,
            child: Container(
              height: screenWidth * 1.6,
              width: screenWidth * 1.6,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 217, 222, 248),
                borderRadius: BorderRadius.all(Radius.circular(500)),
              ),
            ),
          ),
          Positioned(
            bottom: -screenWidth / 2,
            right: -screenWidth * 0.25,
            child: Container(
              height: screenWidth * 1.4,
              width: screenWidth * 1.4,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 178, 188, 231),
                borderRadius: BorderRadius.all(Radius.circular(500)),
              ),
            ),
          ),
          Positioned(
            bottom: -screenWidth / 2,
            right: -screenWidth * 0.125,
            child: Container(
              height: screenWidth * 1.2,
              width: screenWidth * 1.2,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 2, 14, 70),
                borderRadius: BorderRadius.all(Radius.circular(500)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Container(
                      height: screenHeight * 0.075,
                      width: screenWidth * 0.3,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 71, 95, 202),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: const Center(
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Container(
                      height: screenHeight * 0.075,
                      width: screenWidth * 0.3,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 219, 222, 235),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: const Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 71, 95, 202),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
