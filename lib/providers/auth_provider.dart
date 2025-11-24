import 'package:bytelogik/providers/riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_sign_in/google_sign_in.dart';

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider<User?>(
  (ref) => ref.watch(firebaseAuthProvider).authStateChanges(),
);

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>(
  (ref) => GlobalKey<NavigatorState>(),
);

final authProvider = Provider((ref) {
  final auth = ref.watch(firebaseAuthProvider);

  return AuthService(auth);
});

final signupLoadingProvider = StateProvider<bool>((ref) => false);

final loginLoadingProvider = StateProvider<bool>((ref) => false);

class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);
  Future<void> signup(String email, String password, WidgetRef ref) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final uid = credential.user!.uid;
    await FirebaseFirestore.instance.collection("users").doc(uid).set({
      "email": email,
      "createdAt": FieldValue.serverTimestamp(),
      "counter": 0,
    });
  }

  Future<void> login(String email, String password, WidgetRef ref) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;

    final counter = await ref.read(firestoreProvider).getUserCounter(uid);
    ref.read(riverPodhard).setCounter(counter);

    final context = ref.read(navigatorKeyProvider).currentContext;
    if (context != null) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  Future<void> signInWithGoogle(WidgetRef ref) async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // cancelled

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final uid = userCredential.user!.uid;

      // Check if new user → create Firestore record
      final userDoc = FirebaseFirestore.instance.collection("users").doc(uid);
      final snapshot = await userDoc.get();

      if (!snapshot.exists) {
        await userDoc.set({
          "email": userCredential.user!.email,
          "createdAt": FieldValue.serverTimestamp(),
          "counter": 0,
        });
      }

      // Load counter from Firestore
      final counter = await ref.read(firestoreProvider).getUserCounter(uid);
      ref.read(riverPodhard).setCounter(counter);

      // Navigate to home
      final context = ref.read(navigatorKeyProvider).currentContext;
      if (context != null) {
        Navigator.pushReplacementNamed(context, '/');
      }
    } catch (e) {
      print("Google Sign-In Error → $e");
    }
  }

  Future<void> logout() async {
     await GoogleSignIn().signOut();
    await _auth.signOut();
  }
}
