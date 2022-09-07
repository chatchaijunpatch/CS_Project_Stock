import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_stock/storage/user.dart';

class DatabaseService {
  final current = FirebaseAuth.instance.currentUser;
  // final String uid;
  DatabaseService();
  final CollectionReference _UserColletion =
      FirebaseFirestore.instance.collection("users");
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> CreateProfile(UserProfile user) async {
    await _UserColletion.doc(current!.uid).set({
      'email': user.email,
      'username': user.username,
    });
  }

  Future<void> signout() async {
    await auth.signOut();
  }

  Future<String> CallUserName() async {
    UserProfile profile = UserProfile();
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(current!.uid)
          .get()
          .then((value) {
        profile = UserProfile.fromSnapshot(value);
        return profile.username;
      });
    } catch (e) {
      return "Something";
    }
    return profile.username!;
  }

  Future<UserProfile> CallProfile() async {
    UserProfile profile = UserProfile();
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(current!.uid)
          .get()
          .then((value) {
        profile = UserProfile.fromSnapshot(value);
        return profile.username;
      });
    } catch (e) {
      return profile;
    }
    return profile;
  }

  Future<void> UploadProduct(UserProfile profile) async {
    await _UserColletion.doc(current!.uid).collection("product").add({
      "user_id": current!.uid,
      "product_name": profile.product.productname,
      "file_path": profile.product.filepath,
      "file_name": profile.product.filename,
      "description": profile.product.description,
      "cost": profile.product.cost,
      "stock": profile.product.stock,
      "sell": profile.product.sell,
    });
    await uploadFile(profile.product.filepath!, profile.product.filename!);
  }

  Future<void> uploadFile(String filepath,String filename) async {
    // ignore: unused_local_variable
    File file = File(filepath);
    try {
      await FirebaseStorage.instance
          .ref(current!.uid+'/$filename')
          .putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
}
