import 'package:bytelogik/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final isLoading = ref.watch(signupLoadingProvider);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -screenHeight * 0.18,
            left: -screenWidth * 0.2,
            child: Container(
              height: screenWidth * 0.8,
              width: screenWidth * 0.8,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 107, 130, 248),
                borderRadius: BorderRadius.all(Radius.circular(300)),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.05,
            left: screenWidth * 0.05,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/firstpage');
                      },
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Back',
                      style: TextStyle(
                        color: Color.fromARGB(255, 250, 248, 248),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Color.fromARGB(255, 250, 248, 248),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: screenHeight * 0.18,
            right: -screenWidth * 0.05,
            child: Container(
              height: screenWidth * 1.78,
              width: screenWidth * 1.1,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 2, 14, 70),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(220),
                  topRight: Radius.circular(220),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.15,
                  vertical: screenHeight * 0.03,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 45),
                      const Text(
                        'Username ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: username,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(color: Colors.white),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 154, 167, 218),
                              width: 2,
                            ),
                          ),
                          hintText: "Type here..",
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 221, 217, 217),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Email ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: email,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 154, 167, 218),
                              width: 2,
                            ),
                          ),
                          hintText: "Type here..",
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 221, 217, 217),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Password ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: password,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 154, 167, 218),
                              width: 2,
                            ),
                          ),
                          hintText: "Type here..",
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 221, 217, 217),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () async {
                                    ref
                                            .read(
                                              signupLoadingProvider.notifier,
                                            )
                                            .state =
                                        true;

                                    try {
                                      await ref
                                          .read(authProvider)
                                          .signup(
                                            email.text.trim(),
                                            password.text.trim(),
                                            ref,
                                          );

                                      Navigator.pop(context);
                                    } catch (e) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(content: Text(e.toString())),
                                      );
                                    } finally {
                                      ref
                                              .read(
                                                signupLoadingProvider.notifier,
                                              )
                                              .state =
                                          false;
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                71,
                                95,
                                202,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 15,
                              ),
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () async {
    await ref.read(authProvider).signInWithGoogle(ref);
  },
                            child: Container(
                              height: 65,
                              width: 65,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              child: Image.asset('asset/image/Google.png'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
