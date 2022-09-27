import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_stock/Screens/stock/components/cust_react_tween.dart';
import 'package:project_stock/components/text_field_container.dart';
import 'package:project_stock/constants.dart';
import 'package:project_stock/storage/cart.dart';
import 'package:project_stock/storage/user.dart';

import '../../../Service/service.dart';

class EditProductCartPopupCard extends StatefulWidget {
  final Cartproduct;
  const EditProductCartPopupCard({Key? key, this.Cartproduct})
      : super(key: key);

  @override
  State<EditProductCartPopupCard> createState() =>
      _EditProductCartPopupCardState();
}

UserProfile profile = UserProfile();

class _EditProductCartPopupCardState extends State<EditProductCartPopupCard> {
  final formkey = GlobalKey<FormState>();
  dynamic product;
  @override
  void initState() {
    product = widget.Cartproduct;
    // ignore: prefer_interpolation_to_compose_strings
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    UserProfile resultable = await DatabaseService().CallProfile();
    setState(() {
      profile = resultable;
      // print(profile.username);
    });
  }

  var pathimg = "";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 30, top: 200, right: 30, bottom: 200),
        child: Container(
          width: 500,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.white,
            elevation: 0,
            child: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () {},
                      child: new Icon(
                        Icons.remove,
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.white,
                    ),
                    Text('0', style: new TextStyle(fontSize: 60.0)),
                    FloatingActionButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
