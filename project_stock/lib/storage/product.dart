import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Product {
  String? productname;
  String? description;
  String? stock;
  String? cost;
  String? sell;
  String? qrcode;
  String? filepath;
  String? filename;
  String? productid;
  Map<String, dynamic> ToString() => {
        "qrcode": qrcode,
        "product_name": productname,
        "file_path": filepath,
        "file_name": filename,
        "description": description,
        "cost": cost,
        "stock": stock,
        "sell": sell,
        "product_id": productid,
      };
}
