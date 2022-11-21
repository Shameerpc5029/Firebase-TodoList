import 'dart:io';

import 'package:firebase/controller/provider/auth_provider.dart';
import 'package:firebase/controller/provider/user_detials_provider.dart';
import 'package:firebase/view/core/space.dart';
import 'package:firebase/view/core/style.dart';
import 'package:firebase/view/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).downloadImage();
    });
    final provider = Provider.of<UserProvider>(context);
    final provider2 = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                Colors.white,
              ),
            ),
            onPressed: () {
              context.read<AuthProvider>().signOut();
              Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(
                builder: (context) {
                  return const LoginScreen();
                },
              ), (route) => false);
            },
            icon: const Icon(Icons.login_rounded),
            label: const Text('LogOut'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            hight20,
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 53,
                  child: provider.image == null
                      ? const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(
                            'assets/image/—Pngtree—business male icon vector_4187852.png',
                          ),
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(
                            File(
                              provider.image!.path,
                            ),
                          ),
                        ),
                ),
                CircleAvatar(
                  child: InkWell(
                    onTap: () {
                      provider.getImage();
                    },
                    child: const Icon(
                      Icons.photo,
                    ),
                  ),
                ),
              ],
            ),
            hight30,
            Text(
              'Email - ${provider2.firebase.currentUser!.email}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
