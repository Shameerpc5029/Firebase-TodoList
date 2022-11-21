import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserProvider with ChangeNotifier {
  FirebaseAuth firebase = FirebaseAuth.instance;
  bool imageVisible = false;
  final picker = ImagePicker();
  String downloadUrl = "";

  File? image;
  Future<void> getImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final tempImage = File(pickedImage.path);
      image = tempImage;
      log('Image Picked');
      uploadImage();
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> uploadImage() async {
    Reference reference =
        FirebaseStorage.instance.ref().child("${firebase.currentUser!.email}");
    await reference.putFile(image!);
    notifyListeners();
  }

  Future<void> downloadImage() async {
    try {
      Reference reference = FirebaseStorage.instance
          .ref()
          .child("${firebase.currentUser!.email}");
      downloadUrl = await reference.getDownloadURL();
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }
}
