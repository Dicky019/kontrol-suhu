import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/data/repository_auth.dart';
import '../features/auth/presentation/screan_login.dart';
import '../features/kontrol_suhu/presentation/screan_kontrol_suhu.dart';

enum Routes {
  init("/", "home"),
  login("/login", "login"),
  ;

  const Routes(this.value, this.name);
  final String value, name;
}

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return GoRouter(
      initialLocation: Routes.init.value,
      debugLogDiagnostics: false,
      redirect: (_, state)  {
        final loggedIn = authRepository.value != null;
        log(loggedIn.toString());
        final loggingIn = state.location == Routes.login.value;
        if (!loggedIn) return loggingIn ? null : Routes.login.value;
        if (loggingIn) return Routes.init.value;
        return null;
      },
      routes: [
        GoRoute(
          path: Routes.init.value,
          name: Routes.init.name,
          builder: (context, state) => const ScreanKontrolSuhu(),
        ),
        GoRoute(
          path: Routes.login.value,
          name: Routes.login.name,
          builder: (context, state) => const ScreanLogin(),
        ),
      ],
    );
  },
);
