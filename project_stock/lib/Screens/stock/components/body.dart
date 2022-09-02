import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_stock/Service/service.dart';
import 'package:project_stock/storage/user.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserProfile profile = UserProfile();
  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    String resultable =
        await DatabaseService(uid: auth.currentUser!.uid).CallUserName();
    setState(() {
      profile.username = resultable;
      print(profile.username);
    });
  }

  @override
  final auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(auth.currentUser?.email ?? "User"),
          Text(profile.username!)
        ],
      ),
    );
  }
}
