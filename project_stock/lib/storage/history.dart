import 'package:project_stock/storage/product.dart';

class History {
  Product? product;
  DateTime? date;
  String? historyid;
  String? status;
  List? cart;
  Map<String, dynamic> ToUpload() => {
        "product": product!.ToString(),
        "date": date.toString(),
        "status": status,
        "historyid": historyid,
      };
  Map<String, dynamic> ToPayment() => {
        "cart": cart!.toList(),
        "date": date.toString(),
        "status": status,
        "historyid": historyid,
      };
  
}
