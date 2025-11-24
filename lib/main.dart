import 'package:bytelogik/Home_page.dart';
import 'package:bytelogik/auth/StartingPage.dart';
import 'package:bytelogik/auth/login_page.dart';
import 'package:bytelogik/auth/signup_page.dart';
import 'package:bytelogik/firebase_options.dart';
import 'package:bytelogik/providers/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStream = ref.watch(authStateChangesProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: ref.watch(navigatorKeyProvider),
      // home: HomePage(),
      home: userStream.when(
        data: (user) => user != null ? const HomePage() : const StartingPage(),
        loading: () => 
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (error, _) => 
            Scaffold(body: Center(child: Text(error.toString()))),
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpPage(),
        '/firstpage': (context) => const StartingPage(),
      },
    );
  }
}
