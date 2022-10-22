import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:project_stock/storage/cart.dart';
import 'package:project_stock/storage/history.dart';
import 'package:project_stock/storage/product.dart';

class UserProfile {
  String? email;
  String? password;
  String? username;
  String? userid;
  Product product = Product();
  Cart cart = Cart();
  History history = History();
  UserProfile();

  UserProfile.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> dataSnapshot) {
    email = (dataSnapshot['email']);
    username = (dataSnapshot['username']);
  }
  Map<String, dynamic> ToString() => {
        "user_id": userid,
        "product": product.ToString(),
      };
}
