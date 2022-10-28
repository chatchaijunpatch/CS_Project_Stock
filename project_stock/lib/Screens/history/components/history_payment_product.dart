import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Service/service.dart';
import '../../../constants.dart';

class HistoryPayment extends StatefulWidget {
  dynamic p;
  HistoryPayment({Key? key, dynamic p}) : super(key: key);

  @override
  State<HistoryPayment> createState() => _HistoryAddProductState();
}

final auth = FirebaseAuth.instance;

class _HistoryAddProductState extends State<HistoryPayment> {
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
    dynamic product =
        await DatabaseService().CallHistory("payment").then((value) {
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
    var _pageSize = MediaQuery.of(context).size.height;
    var _notifySize = MediaQuery.of(context).padding.top;
    return Container(
      child: Card(
        child: ExpansionTile(
          title: Text("รหัสการชำระเงิน " + his![index]['historyid']),
          subtitle:
              Text(DateTime.parse(his![index]['date'].toString()).toString()),
          children: [
            Container(
              height: 50,
              child: ListView.builder(
                  itemCount: getLength(index),
                  itemBuilder: ((context, index2) {
                    return Column(
                      children: [
                        Text(his![index]['cart'][index2]['product']
                                ['product_id'] +
                            " x "
                                " จำนวน " +
                            his![index]['cart'][index2]['amount'] +
                            " x " +
                            " ฿" +
                            his![index]['cart'][index2]['product']['sell'])
                      ],
                    );
                  })),
            ),
            Text("ราคาทั้งหมด ฿" + getTotal(index).toString()),
          ],
        ),
      ),
    );
  }

  getTotal(int index) {
    int total = 0;
    for (var element in his![index]['cart']) {
      total += (int.parse(element['amount']) *
          int.parse(element['product']['sell']));
    }
    return total;
  }

  getLength(int index) {
    final dynamic rest = his![index]['cart'];
    return rest.length;
  }
}
