import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_stock/storage/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  final CollectionReference _UserColletion =
      FirebaseFirestore.instance.collection("users");
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> CreateProfile(UserProfile user) async {
    await _UserColletion.doc(this.uid).set({
      'email': user.email,
      'username': user.username,
    });
  }

  Future<void> signout() async{
    await auth.signOut();
  }

  Future<String> CallUserName() async {
    UserProfile profile = UserProfile();
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(this.uid)
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
}
