import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/firebase_realtime_kontrol_suhu.dart';
import '../domain/model_kontrol_suhu.dart';

class RepositoryKontrolSuhu
    extends StateNotifier<AsyncValue<ModelKontrolSuhu>> {
  RepositoryKontrolSuhu(this.ref) : super(AsyncData(ModelKontrolSuhu.empty()));

  final Ref ref;
  final _firebaseRealtimeItem = FirebaseRealtimeItem();

  void init() {
    _firebaseRealtimeItem.getAll.forEach((element) {
      String data = json.encode(element.snapshot.value);
      Map<String, dynamic> map = json.decode(data);
      final event = ModelKontrolSuhu.fromMap(map);
      state = AsyncValue.data(event);
    });
  }

  Future change(bool mode, String referensi) async {
    // state = const AsyncValue.loading();
    await _firebaseRealtimeItem.change(mode, referensi);
  }
}

final repositoryKontrolSuhu = StateNotifierProvider<
    RepositoryKontrolSuhu, AsyncValue<ModelKontrolSuhu>>(
  (ref) {
    return RepositoryKontrolSuhu(ref)..init();
  },
);
