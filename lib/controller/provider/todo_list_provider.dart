import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class TodoProvider with ChangeNotifier {
  FirebaseAuth firebase = FirebaseAuth.instance;
  void addTask(String todo) {
    if (todo.isEmpty) {
      return;
    } else {
      FirebaseFirestore.instance
          .collection(
        "${firebase.currentUser!.email}",
      )
          .add({
        "title": todo,
      });
      notifyListeners();
    }
  }

  deleteTask(String id) {
    FirebaseFirestore.instance
        .collection("${firebase.currentUser!.email}")
        .doc(id)
        .delete();
  }
}
