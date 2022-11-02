import 'dart:async';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

class FirebaseRealtimeItem {
  final _firebaseDatabase = FirebaseDatabase.instance;

  Stream<DatabaseEvent> get getAll => _firebaseDatabase.ref("/").onValue;

  Future change(bool mode,String ref) async {
    try {
      await _firebaseDatabase.ref(ref).set(mode);
    } catch (e) {
      log(e.toString());
    }
  }
}
