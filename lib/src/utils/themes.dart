import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MyThemeKeys { light, dark }

class RepositoryThemes extends StateNotifier<ThemeMode> {
  RepositoryThemes() : super(ThemeMode.system);

  final ThemeData lightTheme = ThemeData.light(
    useMaterial3: true
    );

  final ThemeData darkTheme = ThemeData.dark(
    useMaterial3: true
    );

  void change() {
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }
  }
}

final repositoryThemeProvider =
    StateNotifierProvider<RepositoryThemes, ThemeMode>(
  (ref) {
    return RepositoryThemes();
  },
);
