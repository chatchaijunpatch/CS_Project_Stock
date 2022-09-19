import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:project_stock/Screens/stock/components/qr_display.dart';
import 'package:project_stock/Service/service.dart';
import 'package:project_stock/components/hero_dialog_route.dart';
import 'package:project_stock/constants.dart';

class CartProduct extends StatefulWidget {
  @override
  State<CartProduct> createState() => CartProductState();
}

class CartProductState extends State<CartProduct> {
  final double _borderRadius = 8;
  List? items;
  @override
  void initState() {
    // TODO: implement initState
    fetchProductList();
    super.initState();
  }

  fetchProductList() async {
    dynamic product = await DatabaseService().CallCart().then((value) {
      setState(() {
        items = value;
      });
    });
    if (product == null) {
      print("Ubable to retrieve");
    }
  }

  changeImage(String name, int index) async {
    String change = await DatabaseService().getImage(name);
    setState(() {
      items![index]['product']['file_name'] = change;
    });
    Image.network(
      items![index]['product']['file_name'],
      height: 200,
      width: 200,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (items == null) {
      return Center(
          child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: CircularProgressIndicator(),
      ));
    } else {
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: items!.length,
          itemBuilder: (context, index) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 125,
                      decoration: BoxDecoration(
                        color: blueTextColor,
                        borderRadius: BorderRadius.circular(_borderRadius),
                        // gradient: LinearGradient(colors: [
                        //   items[index].startColor,
                        //   items[index].endColor
                        // ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                        boxShadow: [
                          BoxShadow(
                            // color: items[index].endColor,
                            color: Colors.grey.withOpacity(0.4),
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Image.file(
                              File(items![index]['product']["file_path"]),
                              height: 100,
                              width: 200,
                              errorBuilder: (context, error, stackTrace) {
                                changeImage(
                                    items![index]['product']['file_name'],
                                    index);
                                return Image.network(
                                  items![index]['product']['file_name'],
                                  height: 100,
                                  width: 200,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  },
                                );
                              },
                            ),
                            flex: 4,
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  items![index]['product']["product_name"],
                                  style: TextStyle(
                                      color: productTextColor,
                                      fontFamily: 'LEMONMILKBOLD',
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  items![index]['product']["description"],
                                  style: TextStyle(
                                    color: productTextColor,
                                    fontFamily: 'LEMONMILK',
                                  ),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.inbox_outlined,
                                      color: secondaryProductTextColor,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                      child: Text(
                                        items![index]['product']['stock'],
                                        style: TextStyle(
                                          color: secondaryProductTextColor,
                                          fontFamily: 'LEMONMILK',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                // FlatButton(
                                //   onPressed: () {
                                //     Navigator.of(context).push(
                                //         HeroDialogRoute(builder: (context) {
                                //       return QrProductDisply(
                                //         qrcode: items![index]['product']['qrcode'],
                                //       );
                                //     }));
                                //   },
                                //   child: Icon(Icons.qr_code),
                                // ),
                                Text(
                                  "AMOUNT : " + items![index]['amount'],
                                  style: TextStyle(
                                      color: thirdProductTextColor,
                                      fontFamily: 'LEMONMILKBOLD',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "฿" +
                                      (int.parse(items![index]['product']
                                                  ['sell']) *
                                              int.parse(
                                                  items![index]['amount']))
                                          .toString(),
                                  style: TextStyle(
                                      color: thirdProductTextColor,
                                      fontFamily: 'LEMONMILKBOLD',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                // RatingBar(rating: items[index].rating),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}