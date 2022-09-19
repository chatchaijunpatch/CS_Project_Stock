import 'package:project_stock/storage/product.dart';

class Cart {
  Product? product;
  String? amount;
  String? cartid;
  Map<String, dynamic> ToString() => {
        "product": product!.ToString(),
        "amount": amount,
        "cartid": cartid,
      };
}
