import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kontrol_suhu/src/utils/alert.dart';
import 'package:kontrol_suhu/src/common_widget/kontrol_suhu/text_info_widget.dart';
import 'package:kontrol_suhu/src/features/auth/domain/model_auth.dart';

import '../../../common_widget/kontrol_suhu/switch_costum.dart';
import '../../../utils/themes.dart';
import '../../auth/data/repository_auth.dart';
import '../data/repository_item.dart';

class ScreanKontrolSuhu extends ConsumerWidget {
  const ScreanKontrolSuhu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepoProvider = ref.read(authRepositoryProvider.notifier);
    final authRepo = ref.watch(authRepositoryProvider);
    // final themeRepositoryProvider = ref.watch(repositoryThemeProvider.notifier);
    // final themeProvider = ref.watch(repositoryThemeProvider);
    log("message");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kontrol Suhu"),
        actions: [
          Consumer(builder: (context, ref, _) {
            final themeRepositoryProvider =
                ref.watch(repositoryThemeProvider.notifier);
            final themeProvider = ref.watch(repositoryThemeProvider);
            return IconButton(
              onPressed: themeRepositoryProvider.change,
              icon: themeProvider == ThemeMode.dark
                  ? const Icon(FontAwesomeIcons.moon)
                  : const Icon(FontAwesomeIcons.sun),
            );
          }),
          IconButton(
            onPressed: () async {
              final isLogout = await Alert.showAlertDialog(context) ?? false;
              if (isLogout) {
                await authRepoProvider.logout();
              }
            },
            icon: const Icon(FontAwesomeIcons.rightFromBracket),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final kontrolSuhuProvider = ref.read(repositoryKontrolSuhu.notifier);
          return ref.watch(repositoryKontrolSuhu).when(data: (data) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: TextInfoWidget(
                        title: 'Kelembapan',
                        value: "${data.kelembapan}%",
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                      child: VerticalDivider(),
                    ),
                    Expanded(
                      child: TextInfoWidget(
                        title: 'Suhu',
                        value: "${data.suhu}°",
                      ),
                    ),
                  ],
                ),
                if (authRepo.value != ModelAuth.empty()) const Divider(),
                if (authRepo.value != ModelAuth.empty())
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: SwitchCostum(
                          title: 'Kipas',
                          value: data.kontrol,
                          onChanged: data.mode
                              ? null
                              : (mode) async {
                                  log("kontrol");
                                  await kontrolSuhuProvider.change(
                                      mode, "/Kontrol");
                                },
                        ),
                      ),
                      const SizedBox(
                        height: 45,
                        child: VerticalDivider(),
                      ),
                      Expanded(
                        child: SwitchCostum(
                          title: 'Mode',
                          value: data.mode,
                          onChanged: (mode) async {
                            log("mode");
                            await kontrolSuhuProvider.change(mode, "/Mode");
                          },
                        ),
                      ),
                    ],
                  ),
                const Divider(),
              ],
            );
          }, error: (error, _) {
            return Center(child: Text(error.toString()));
          }, loading: () {
            log("loading");
            return const Center(child: CircularProgressIndicator());
          });
        },
      ),
    );
  }
}
