import 'dart:io';

import 'package:firebase/controller/provider/auth_provider.dart';
import 'package:firebase/controller/provider/user_detials_provider.dart';
import 'package:firebase/view/login/login_screen.dart';
import 'package:firebase/view/settings/setting_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    return StreamBuilder<User?>(
      stream: context.watch<AuthProvider>().stream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoginScreen();
        }
        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) => SettingsScreen(),
                    ));
                  },
                  child: provider.image == null
                      ? const CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/image/—Pngtree—business male icon vector_4187852.png',
                          ),
                        )
                      : CircleAvatar(
                          backgroundImage:
                              FileImage(File(provider.image!.path)),
                        ),
                ),
              ),
            ],
            title: const Text("Home screen"),
          ),
        );
      },
    );
  }
}
