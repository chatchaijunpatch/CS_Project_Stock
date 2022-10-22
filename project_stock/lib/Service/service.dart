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

  Future CallCart() async {
    List product = [];
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(current!.uid)
          .collection("cart")
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          product.add(element.data());
          // print(element.data());
        });
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
    return product;
  }

  Future<void> UploadProduct(UserProfile profile) async {
    var intValue = Random().nextInt(4294967296);
    profile.userid = current!.uid;
    profile.product.qrcode = intValue.toString();
    final docProduct =
        await _UserColletion.doc(current!.uid).collection("product").doc();
    profile.product.productid = docProduct.id;
    await docProduct.set(profile.ToString());
    await uploadFile(profile.product.filepath!, profile.product.filename!);
  }

  Future<void> UpdateAmountProduct(dynamic cart_id, int amount) async {
    final updateProduct = await _UserColletion.doc(current!.uid)
        .collection("cart")
        .doc(cart_id)
        .update({
      "amount": amount.toString(),
    });
  }

  Future<void> UpdateProduct(UserProfile product) async {
    final updateProduct = await _UserColletion.doc(current!.uid)
        .collection("product")
        .doc(product.product.productid)
        .update(product.ToString())
        .then((value) async {
      List cartdemo = await CallCart();
      for (var cart in cartdemo) {
        if (product.product.productid == cart['product']['product_id']) {
          final updateCart = await _UserColletion.doc(current!.uid)
              .collection("cart")
              .doc(cart['cartid'])
              .update(product.ToString());
        }
      }
    });
  }

  Future<void> DeleteCartProduct(dynamic cart_id, String type) async {
    final delCartProduct = await _UserColletion.doc(current!.uid)
        .collection(type)
        .doc(cart_id)
        .delete();
  }

  Future<void> UploadCart(UserProfile profile) async {
    List cartdemo = await CallCart();
    int stats = 0;
    if (cartdemo.length == 0) {
      await UploadCartData(profile);
    } else {
      //ซ้ำ
      for (var cart in cartdemo) {
        if (profile.cart.product!.qrcode == cart['product']['qrcode']) {
          if ((int.parse(cart['amount']) <
              int.parse(cart['product']['stock']))) {
            await _UserColletion.doc(current!.uid)
                .collection('cart')
                .doc(cart['cartid'])
                .update({
              "amount":
                  (int.parse(cart['amount']) + int.parse(profile.cart.amount!))
                      .toString(),
            });
          }
          stats = 1;
          break;
        }
      }
      if (stats == 0) {
        await UploadCartData(profile);
      }
    }
  }

  UploadCartData(UserProfile profile) async {
    var docCart =
        await _UserColletion.doc(current!.uid).collection("cart").doc();
    profile.cart.cartid = docCart.id;
    await docCart.set(profile.cart.ToString());
  }

  UploadHistory(UserProfile profile, status) async {
    profile.userid = current!.uid;
    final docProduct =
        await _UserColletion.doc(current!.uid).collection("history").doc();
    profile.history.historyid = docProduct.id;
    profile.history.date = new DateTime.now();
    profile.history.status = status;
    profile.history.product = profile.product;
    if (status == "upload") {
      await docProduct.set(profile.history.ToUpload());
    }
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
