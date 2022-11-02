import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../common_widget/auth/outline_button_custom.dart';
import '../data/repository_auth.dart';

class ScreanLogin extends ConsumerWidget {
  const ScreanLogin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    // final authProvider = ref.watch(authRepositoryProvider);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.asset(
              "assets/login.png",
              height: 300,
              width: size.width,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 350.0,
                  maxWidth: 500.0,
                ),
                child: ListView(
                  children: [
                    SizedBox(
                      width: size.width * 0.7,
                      child: const Text(
                        """Lorem ipsum, dolor sit amet consectetur adipisicing elit. 
Enim sit, reiciendis ipsam repellat esse voluptate officiis aliquid 
recusandae consequatur libero doloremque minima nostrum dolorem optio 
deserunt quam incidunt sunt adipisci?""",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Consumer(builder: (context, ref, _) {
                        final authProvider = ref.watch(authRepositoryProvider);
                        return OutlineButtonCostum(
                          onPressed: authProvider.isLoading
                              ? null
                              : ref
                                  .read(authRepositoryProvider.notifier)
                                  .loginAdmin,
                          color: authProvider.isLoading
                              ? Colors.grey
                              : Colors.blueAccent,
                          iconData: FontAwesomeIcons.google,
                          label: "Login with Google",
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: const [
                        Expanded(
                            child: Divider(
                          indent: 25,
                          endIndent: 10,
                        )),
                        Text(
                          "OR",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Expanded(
                            child: Divider(
                          indent: 10,
                          endIndent: 25,
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Consumer(builder: (context, ref, _) {
                        final authProvider = ref.watch(authRepositoryProvider);
                        return OutlineButtonCostum(
                          onPressed: authProvider.isLoading
                              ? null
                              : ref
                                  .read(authRepositoryProvider.notifier)
                                  .loginAnonimus,
                          color: authProvider.isLoading
                              ? Colors.black
                              : Colors.grey,
                          iconData: FontAwesomeIcons.person,
                          label: "Login with Anonim",
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
