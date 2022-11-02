import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/firebase_login_servise.dart';
import '../domain/model_auth.dart';
import 'package:flutter/foundation.dart'
    show  kIsWeb;

class RepositoryAuth extends StateNotifier<AsyncValue<ModelAuth?>> {
  RepositoryAuth()
      : super(
          const AsyncData(null),
        );

  final _firebaseAuthService = FirebaseAuthService();
  final _firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference<ModelAuth> get _firebaseCollection =>
      _firebaseFirestore.collection("user").withConverter(
            fromFirestore: (snapshot, options) =>
                ModelAuth.fromMap(snapshot.data()!, snapshot.id),
            toFirestore: (value, options) => value.toMap(),
          );

  void init() {
    final user = _firebaseAuthService.userCurrent;
    if (user == null) {
      return;
    }
    if (user.isAnonymous) {
      state = AsyncValue.data(
        ModelAuth.empty(),
      );
      return;
    }
    _firebaseCollection.doc(user.uid).snapshots().listen((event) {
      state = AsyncValue.data(
        event.data(),
      );
    });
  }

  Future<void> loginAdmin() async {
    state = const AsyncValue.loading();
    final modelAuth = kIsWeb ? await _firebaseAuthService.loginAdminWeb() :  await _firebaseAuthService.loginAdmin();
    final data = await _firebaseCollection.doc(modelAuth!.user!.uid).get();
    state = AsyncValue.data(
      data.data(),
    );
    if (data.data() == null) {
      logout();
    }
  }

  Future<void> loginAnonimus() async {
    state = const AsyncValue.loading();
    await _firebaseAuthService.loginAnonimus();
    state = AsyncValue.data(ModelAuth.empty());
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    await _firebaseAuthService.logout();
    state = const AsyncValue.data(null);
  }
}

final authRepositoryProvider =
    StateNotifierProvider<RepositoryAuth, AsyncValue<ModelAuth?>>(
  (ref) {
    final repo = RepositoryAuth()..init();

    return repo;
  },
);
