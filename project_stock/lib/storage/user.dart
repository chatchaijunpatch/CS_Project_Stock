import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class UserProfile {
  String? email;
  String? password;
  String? username;
  UserProfile({this.email = '', this.password = '',this.username = ''});
  
  UserProfile.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> dataSnapshot) {
    email = (dataSnapshot['email']);
    username =  (dataSnapshot['username']);
  }
}
