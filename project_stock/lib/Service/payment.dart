import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

Future<String?> accessToken(String uuid) async {
  var accessToken;
  try {
    var response = await http
        .post(
            Uri.parse(
                "https://api-sandbox.partners.scb/partners/sandbox/v1/oauth/token"),
            headers: {
              "Content-Type": "application/json",
              "accept-language": "EN",
              "accept": "application/json",
              "requestUId": uuid,
              "resourceOwnerId": "l75f7c6f7e5fcd43d8b6711147b1dd94fb",
            },
            body: jsonEncode({
              "applicationKey": "l75f7c6f7e5fcd43d8b6711147b1dd94fb",
              "applicationSecret": "9394053baaba46fa951da8f1e34153b3"
            }))
        .then((value) {
      // print("KUY" + value.headers.toString());
      accessToken = jsonDecode(value.body)["data"]['accessToken'].toString();
    });

    return accessToken;
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future<String?> generateMaemaneePaymentQRcode(String uuid, String token) async {
  var result;
  try {
    Dio dio = new Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] = 'bearer ' + token.toString();
    dio.options.headers['accept-language'] = 'th';
    dio.options.headers['resourceOwnerId'] =
        'l75f7c6f7e5fcd43d8b6711147b1dd94fb';
    dio.options.headers['requestUId'] = 'e798ae11-4ae9-452f-9949-c121daf13895';

    dynamic response = await dio
        .post(
            "https://api-sandbox.partners.scb/partners/sandbox/v1/maemanee/payment/qr/create",
            data: jsonEncode({
              "partnerReferenceNo": "100000100",
              "walletId": "014676584185241",
              "paymentType": ["T30", "QRCS", "ALIPAY", "WECHAT"],
              "amount": 1000.00,
              "partnerOrderDate": "2020-07-16T19:20:30.45+01:00",
              "partnerMetaData": ""
            }),
            options: Options(
              validateStatus: (_) => true,
              responseType: ResponseType.json,
            ))
        .then((value) {
      result = value.data['data']['tag30']['qrImage'].toString();
    });
    return result;
  } catch (e) {
    print("GG" + e.toString());
  }
}
