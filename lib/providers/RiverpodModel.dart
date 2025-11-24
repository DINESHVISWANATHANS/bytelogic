import 'package:bytelogik/providers/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Riverpodmodel extends ChangeNotifier {
  int counter;
  List<bool> myColors = List.generate(12, (_) => false);

  Riverpodmodel({required this.counter});

  void setCounter(int value) {
    counter = value;
    myColors = List.generate(12, (i) => i < counter);
    notifyListeners();
  }

  void addcounter(String uid, WidgetRef ref) {
    if (counter < myColors.length) {
      myColors[counter] = true;
      counter++;

      // update Firestore counter
      ref.read(firestoreProvider).updateUserCounter(uid, counter);

      notifyListeners();
    }
  }

  void removecounter(String uid, WidgetRef ref) {
    if (counter > 0) {
      counter--;
      myColors[counter] = false;

      // update Firestore
      ref.read(firestoreProvider).updateUserCounter(uid, counter);

      notifyListeners();
    }
  }

  void resetcounter(String uid, WidgetRef ref) {
    counter = 0;
    myColors = List.generate(12, (_) => false);

    // update Firestore
    ref.read(firestoreProvider).updateUserCounter(uid, counter);

    notifyListeners();
  }
}
