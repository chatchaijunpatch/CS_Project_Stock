import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_stock/Screens/stock/components/display_product.dart';
import 'package:project_stock/Service/service.dart';
import 'package:project_stock/components/hero_dialog_route.dart';
import 'package:project_stock/storage/user.dart';
import 'package:project_stock/Screens/stock/components/add_product.dart';

import 'cust_react_tween.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

UserProfile profile = UserProfile();

class _BodyState extends State<Body> {
  @override
  void initState() {
    fetchDatabaseList();
    super.initState();
  }

  fetchDatabaseList() async {
    dynamic resultable = await DatabaseService().CallUserName().then((value) {
      setState(() {
        profile.username = value;
      });
    });
    if (resultable == null) {
      print("Unable to retrieve");
    }
    // setState(() {
    //   profile.username = resultable;
    //   // print(profile.username);
    // });
  }

  @override
  final auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    if (profile.username == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Text(auth.currentUser?.email ?? "User"),
          Text(profile.username!),
          DisplayProduct(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(HeroDialogRoute(
            builder: (context) {
              return AddProductPopupCard();
            },
          ));
        },
        child: Text("+"),
        backgroundColor: Colors.red,
      ),
    );
  }
}
