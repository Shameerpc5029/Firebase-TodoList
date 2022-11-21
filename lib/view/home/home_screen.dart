import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/controller/provider/auth_provider.dart';
import 'package:firebase/controller/provider/todo_list_provider.dart';
import 'package:firebase/controller/provider/user_detials_provider.dart';
import 'package:firebase/view/core/space.dart';
import 'package:firebase/view/core/style.dart';

import 'package:firebase/view/login/login_screen.dart';
import 'package:firebase/view/widgets/text_form_field.dart';
import 'package:firebase/view/settings/setting_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final TextEditingController todo = TextEditingController();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    final providerTodo = Provider.of<TodoProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).downloadImage();
    });

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
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                  child: provider.image == null
                      ? provider.downloadUrl.isEmpty
                          ? const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.person),
                            )
                          : CircleAvatar(
                              backgroundImage: NetworkImage(
                                provider.downloadUrl,
                              ),
                            )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                            File(provider.image!.path),
                          ),
                        ),
                ),
              ),
            ],
            title: const Text("Home screen"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                Column(
                  children: [
                    hight10,
                    TextFormFieldCustom(
                      labelText: 'Enter User Task',
                      controller: todo,
                      keyboardType: TextInputType.multiline,
                      suffix: IconButton(
                        onPressed: () {
                          providerTodo.addTask(todo.text);
                          todo.clear();
                        },
                        icon: const Icon(
                          Icons.check,
                        ),
                        splashRadius: 20,
                        color: Colors.blue,
                      ),
                    ),
                    hight10,
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("${provider.firebase.currentUser!.email}")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator(
                            strokeWidth: 2,
                          );
                        } else {
                          return ListView(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            children: snapshot.data!.docs.map((documets) {
                              return Consumer<TodoProvider>(
                                builder: (context, value, child) {
                                  return Dismissible(
                                    key: Key(documets.id),
                                    onDismissed: (direction) {
                                      value.deleteTask(documets.id);
                                    },
                                    background: Container(
                                      color: Colors.red,
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        documets["title"],
                                        style: textStyel3,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          );
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
