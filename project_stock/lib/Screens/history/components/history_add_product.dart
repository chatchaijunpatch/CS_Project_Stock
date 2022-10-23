import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Service/service.dart';

class HistoryAddProduct extends StatefulWidget {
  dynamic p;
  HistoryAddProduct({Key? key, dynamic p}) : super(key: key);

  @override
  State<HistoryAddProduct> createState() => _HistoryAddProductState();
}

final auth = FirebaseAuth.instance;

class _HistoryAddProductState extends State<HistoryAddProduct> {
  List? his;
  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  fetchData() async {
    dynamic product =
        await DatabaseService().CallHistory("upload").then((value) {
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
            itemBuilder: (context, index) {
              return Container(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("เพิ่มสินค้าใหม่รหัส " +
                                  his![index]['product']['product_id']),
                            ),
                          ],
                        ),
                        //Row()
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
    }
  }
}
