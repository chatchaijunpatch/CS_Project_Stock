import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DisplayProduct extends StatelessWidget {
  const DisplayProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
        child: Column(
          children: [
            Positioned(
              top: 35,
                child: Material(
              child: Container(
                  height: 180,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: new Offset(-10, 10),
                            blurRadius: 20.0,
                            spreadRadius: 4.0),
                      ])),
            ))
          ],
        ),
      ),
    );
  }
}
