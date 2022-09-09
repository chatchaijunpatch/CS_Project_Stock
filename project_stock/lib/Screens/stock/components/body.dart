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
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    String resultable = await DatabaseService().CallUserName();
    setState(() {
      profile.username = resultable;
      // print(profile.username);
    });
  }

  @override
  final auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
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
