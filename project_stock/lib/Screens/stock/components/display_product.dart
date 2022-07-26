import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_stock/Screens/stock/components/add_amount.dart';
import 'package:project_stock/Screens/stock/components/add_product.dart';
import 'package:project_stock/Screens/stock/components/edit_product.dart';
import 'package:project_stock/Screens/stock/components/qr_display.dart';
import 'package:project_stock/Service/service.dart';
import 'package:project_stock/components/hero_dialog_route.dart';
import 'package:project_stock/constants.dart';

import '../../cart/components/edit_product_cart.dart';

class DisplayProduct extends StatefulWidget {
  @override
  State<DisplayProduct> createState() => DisplayProductState();
}

class DisplayProductState extends State<DisplayProduct> {
  final double _borderRadius = 8;
  List? items;
  @override
  void initState() {
    // TODO: implement initState
    fetchProductList();
    super.initState();
  }

  fetchProductList() async {
    dynamic product = await DatabaseService().CallProduct().then((value) {
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

  // var items = [
  //   PlaceInfo('Dubai Mall Food Court', Color(0xff6DC8F3), Color(0xff73A1F9),
  //       4.4, 'Dubai · In The Dubai Mall', 'Cosy · Casual · Good for kids'),
  //   PlaceInfo('Hamriyah Food Court', Color(0xffFFB157), Color(0xffFFA057), 3.7,
  //       'Sharjah', 'All you can eat · Casual · Groups'),
  //   PlaceInfo('Gate of Food Court', Color(0xffFF5B95), Color(0xffF8556D), 4.5,
  //       'Dubai · Near Dubai Aquarium', 'Casual · Groups'),
  //   PlaceInfo('Express Food Court', Color(0xffD76EF5), Color(0xff8F7AFE), 4.1,
  //       'Dubai', 'Casual · Good for kids · Delivery'),
  //   PlaceInfo('BurJuman Food Court', Color(0xff42E695), Color(0xff3BB2B8), 4.2,
  //       'Dubai · In BurJuman', '...'),
  // ];

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
                child: Slidable(
                  key: Key(items![index].toString()),
                  endActionPane: ActionPane(
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(
                          icon: Icons.create,
                          label: "แก้ไข",
                          backgroundColor: Colors.blue,
                          onPressed: (context) {
                            Navigator.of(context).push(HeroDialogRoute(
                              builder: (context) {
                                return EditProductDataPopupCard(
                                  product: items![index]['product'],
                                );
                              },
                            ));
                          }),
                      SlidableAction(
                          icon: Icons.delete,
                          label: "ลบสินค้า",
                          backgroundColor: Colors.red,
                          onPressed: (context) {
                            DatabaseService()
                                .DeleteCartProduct(
                                    items![index]['product']['product_id'],
                                    "product")
                                .then((value) {
                              Fluttertoast.showToast(
                                      msg:
                                          "สินค้า ${items![index]['product']['product_name']} ลบสำเร็จ",
                                      gravity: ToastGravity.CENTER)
                                  .then((value) {
                                setState(() {
                                  fetchProductList();
                                });
                              });
                            });
                          }),
                    ],
                    extentRatio: 0.35,
                  ),
                  child: Builder(builder: (context) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(HeroDialogRoute(
                          builder: (context) {
                            return AddAmountProductToCart(
                                Cartproduct: items![index]);
                          },
                        ));
                        // final slidable = Slidable.of(context);
                        // slidable?.direction.value == 0
                        //     ? slidable?.openEndActionPane(
                        //         duration: const Duration(milliseconds: 500),
                        //         curve: Curves.decelerate,
                        //       )
                        //     : slidable?.close(
                        //         duration: const Duration(milliseconds: 500),
                        //         curve: Curves.decelerate,
                        //       );
                      },
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 125,
                            decoration: BoxDecoration(
                              color: blueTextColor,
                              borderRadius:
                                  BorderRadius.circular(_borderRadius),
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
                          // Positioned(
                          //   right: 0,
                          //   bottom: 0,
                          //   top: 0,
                          //   child: CustomPaint(
                          //     size: Size(100, 150),
                          //     painter: CustomCardShapePainter(_borderRadius,
                          //         items[index].startColor, items[index].endColor),
                          //   ),
                          // ),
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
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        },
                                      );
                                    },
                                  ),
                                  flex: 4,
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        items![index]['product']
                                            ["product_name"],
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
                                                color:
                                                    secondaryProductTextColor,
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
                                  flex: 3,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        items![index]['product']["product_id"],
                                        style: TextStyle(
                                            color: productTextColor,
                                            fontSize: 10,
                                            fontFamily: 'LEMONMILKBOLD'),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              HeroDialogRoute(
                                                  builder: (context) {
                                            return QrProductDisply(
                                              qrcode: items![index]['product']
                                                  ['qrcode'],
                                            );
                                          }));
                                        },
                                        child: Icon(Icons.qr_code),
                                      ),
                                      Text(
                                        "฿" + items![index]['product']['sell'],
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
                    );
                  }),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}

class PlaceInfo {
  final String name;
  final String category;
  final String location;
  final double rating;
  final Color startColor;
  final Color endColor;

  PlaceInfo(this.name, this.startColor, this.endColor, this.rating,
      this.location, this.category);
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
