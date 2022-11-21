import 'package:firebase/controller/provider/auth_provider.dart';
import 'package:firebase/view/core/space.dart';
import 'package:firebase/view/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                const CircleAvatar(
                  radius: 55,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://static01.nyt.com/images/2019/04/16/sports/16onsoccerweb-2/merlin_153612873_5bb119b9-8972-4087-b4fd-371cab8c5ba2-superJumbo.jpg?quality=75&auto=webp'),
                  ),
                ),
                CircleAvatar(
                  child: InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.photo,
                    ),
                  ),
                ),
              ],
            ),
            hight30,
            const Text('Email - ')
          ],
        ),
      ),
    );
  }
}
