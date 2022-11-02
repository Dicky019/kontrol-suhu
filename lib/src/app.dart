import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kontrol_suhu/src/utils/themes.dart';

import 'routes/routes.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(context, ref) {
    return MaterialApp.router(
      theme: ref.read(repositoryThemeProvider.notifier).lightTheme,
      themeMode: ref.watch(repositoryThemeProvider),
      darkTheme: ref.read(repositoryThemeProvider.notifier).darkTheme,
      routerConfig: ref.watch(goRouterProvider),
    );
  }
}
