import 'package:firebase/controller/provider/auth_provider.dart';
import 'package:firebase/view/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: context.watch<AuthProvider>().stream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoginScreen();
        }
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () => context.read<AuthProvider>().signOut(),
                icon: const Icon(
                  Icons.login_outlined,
                ),
                splashRadius: 20,
              )
            ],
            title: const Text("Home screen"),
          ),
        );
      },
    );
  }
}
