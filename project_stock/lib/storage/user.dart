import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:project_stock/storage/product.dart';

class UserProfile {
  String? email;
  String? password;
  String? username;
  Product product = Product();
  UserProfile();

  UserProfile.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> dataSnapshot) {
    email = (dataSnapshot['email']);
    username = (dataSnapshot['username']);
  }
}
