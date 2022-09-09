import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart';
import 'package:project_stock/storage/product.dart';
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

  Future CallProduct() async {
    List product = [];
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(current!.uid)
          .collection("product")
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          product.add(element.data());
          // print(element.data());
        });
      });
      // .then((value) async {
      //   product = await getImage(product);
      //   return product;
      // });
      // product = await getImage(product);
    } catch (e) {
      print(e.toString());
      return null;
    }
    return product;
  }

  Future<void> UploadProduct(UserProfile profile) async {
    var intValue = Random().nextInt(4294967296);
    profile.product.qrcode = intValue.toString();
    print(profile.product.qrcode);
    await _UserColletion.doc(current!.uid).collection("product").add({
      "user_id": current!.uid,
      "qrcode": profile.product.qrcode,
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

  Future<void> uploadFile(String filepath, String filename) async {
    Image image = decodeImage(File(filepath).readAsBytesSync())!;
    Image thumbnail = copyResize(image, width: 120);
    var compressImage = new File(filepath)
      ..writeAsBytesSync(encodeJpg(thumbnail, quality: 50));
    File file = File(filepath);
    try {
      await FirebaseStorage.instance
          .ref(current!.uid + '/$filename')
          .putFile(compressImage);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<List> ggetImage(List product) async {
    for (var i = 0; i < product.length; i++) {
      String dumy = product[i]['file_name'];
      String downloadURL = await FirebaseStorage.instance
          .ref(current!.uid + '/$dumy')
          .getDownloadURL();
      product[i]['file_name'] = downloadURL;
    }
    return product;
  }

  Future<String> getImage(String name) async {
    String downloadURL = await FirebaseStorage.instance
        .ref(current!.uid + '/$name')
        .getDownloadURL();
    return downloadURL;
  }
}
