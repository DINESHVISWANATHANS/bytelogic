import 'package:bytelogik/providers/FirestoreService.dart';
import 'package:bytelogik/providers/RiverpodModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';


final riverPodhard = ChangeNotifierProvider<Riverpodmodel>(
  (ref) => Riverpodmodel(counter: 0),
);

final firestoreProvider = Provider((ref) => FirestoreService());

final passVisibleProvider = StateProvider<bool>((ref) => true);
