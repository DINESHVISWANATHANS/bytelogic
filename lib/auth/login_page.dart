import 'package:bytelogik/providers/auth_provider.dart';
import 'package:bytelogik/providers/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late TextEditingController email;
  late TextEditingController password;

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pass = ref.watch(passVisibleProvider);
    final isLoading = ref.watch(loginLoadingProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                  'Log In',
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
              height: screenWidth * 1.8,
              width: screenWidth * 1.1,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 217, 222, 248),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(220),
                  topRight: Radius.circular(220),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.245,
            right: -screenWidth * 0.05,
            child: Container(
              height: screenWidth * 1.7,
              width: screenWidth * 1.1,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 178, 188, 231),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(220),
                  topRight: Radius.circular(220),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.31,
            right: -screenWidth * 0.05,
            child: Container(
              height: screenWidth * 1.6,
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
                  vertical: screenHeight * 0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
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
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            ref.read(passVisibleProvider.notifier).state =
                                !pass;
                          },
                          icon: Icon(
                            pass ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
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
                      obscureText: pass,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: isLoading
                              ? null
                              : () async {
                                  ref
                                          .read(loginLoadingProvider.notifier)
                                          .state =
                                      true;

                                  try {
                                    await ref
                                        .read(authProvider)
                                        .login(
                                          email.text.trim(),
                                          password.text.trim(),
                                          ref,
                                        );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())),
                                    );
                                  } finally {
                                    ref
                                            .read(loginLoadingProvider.notifier)
                                            .state =
                                        false;
                                  }
                                },
                          child: Container(
                            height: 60,
                            width: 120,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 71, 95, 202),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: isLoading
                                  ? const SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
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
                      ],
                    ),
                    const SizedBox(height: 50),
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
        ],
      ),
    );
  }
}
