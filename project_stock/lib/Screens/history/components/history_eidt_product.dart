import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Service/service.dart';
import '../../../constants.dart';

class HistoryEditProduct extends StatefulWidget {
  const HistoryEditProduct({Key? key}) : super(key: key);

  @override
  State<HistoryEditProduct> createState() => _HistoryAddProductState();
}

final auth = FirebaseAuth.instance;

class _HistoryAddProductState extends State<HistoryEditProduct> {
  changeImage(String name, int index) async {
    String change = await DatabaseService().getImage(name);
    setState(() {
      his![index]['product']['file_name'] = change;
    });
    Image.network(
      his![index]['product']['file_name'],
      height: 200,
      width: 200,
    );
  }

  List? his;
  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  fetchData() async {
    dynamic product = await DatabaseService().CallHistory("edit").then((value) {
      setState(() {
        his = value;
      });
    });
    if (product == null) {
      //เดี๋ยวมาแก้
      print("Ubable to retrieve");
    }
  }

  @override
  Widget build(BuildContext context) {
    var _pageSize = MediaQuery.of(context).size.height;
    var _notifySize = MediaQuery.of(context).padding.top;
    if (his == null) {
      return Center(
          child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: CircularProgressIndicator(),
      ));
    } else {
      return Container(
        height: _pageSize - (187 + _notifySize),
        child: ListView.builder(
            itemCount: his!.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return _buildPlayerModelList(index);
            }),
      );
    }
  }

  // Widget _buildPlayerModelList(int index) {
  //   return Container(
  //     child: Card(
  //       child: Padding(
  //         padding: const EdgeInsets.all(12),
  //         child: Column(
  //           children: [
  //             Row(
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.only(bottom: 10.0),
  //                   child: Text("เพิ่มสินค้าใหม่รหัส " +
  //                       his![index]['product']['product_id']),
  //                 ),
  //               ],
  //             ),
  //             //Row()
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget _buildPlayerModelList(int index) {
    return Container(
      child: Card(
        child: ExpansionTile(
          title: Text(
              "เพิ่มสินค้าใหม่รหัส" + his![index]['product']['product_id']),
          subtitle:
              Text(DateTime.parse(his![index]['date'].toString()).toString()),
          children: [
            Image.file(
              File(his![index]['product']["file_path"]),
              height: 100,
              width: 200,
              errorBuilder: (context, error, stackTrace) {
                changeImage(his![index]['product']['file_name'], index);
                return Image.network(
                  his![index]['product']['file_name'],
                  height: 100,
                  width: 200,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: CircularProgressIndicator());
                  },
                );
              },
            ),
            Text("ชื่อสินค้า " + his![index]['product']["product_name"],
                style: TextStyle(
                  color: productTextColor,
                  fontFamily: 'LEMONMILK',
                )),
            Text(
              "คำอธิบาย " + his![index]['product']["description"],
              style: TextStyle(
                color: productTextColor,
                fontFamily: 'LEMONMILK',
              ),
            ),
            Text(
              "จำนวน " + his![index]['product']["stock"],
              style: TextStyle(
                color: productTextColor,
                fontFamily: 'LEMONMILK',
              ),
            ),
            Text(
              "ราคาต้นทุน " + his![index]['product']["cost"],
              style: TextStyle(
                color: productTextColor,
                fontFamily: 'LEMONMILK',
              ),
            ),
            Text(
              "ราคาขาย " + his![index]['product']["sell"],
              style: TextStyle(
                color: productTextColor,
                fontFamily: 'LEMONMILK',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
