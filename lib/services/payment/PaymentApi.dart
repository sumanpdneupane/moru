import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:moru/services/ApiUrls.dart';
import 'package:moru/services/BaseAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:moru/utils/Commons.dart';

class PaymentApi extends BaseAPI {
  Future<double> getProduct(String priceId) async {
    // Map<String, dynamic> map = Map();
    // map["data"] = {"id": priceId}.toString();
    // await httpPostRequest(
    //   destinationUrl: ApiUrls.GET_PRODUCT_ODER_AMMOUNT,
    //   body: map,
    // );

    final url = Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_PRODUCT_ODER_AMMOUNT);
    final headers = {"Content-type": "application/json"};
    final json = '{"data": { "id": "${priceId}"}}';
    final response = await http.post(url, headers: headers, body: json);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');

    //Response and converter
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var result = jsonResponse["result"];

    double unit_amount = 0;
    if (result.containsKey("unit_amount")) {
      unit_amount = result["unit_amount"];
    }

    return unit_amount;
  }

  Future<dynamic> payWithProduct(Map<String, dynamic> data, BuildContext context) async {
    final url = Uri.parse(
      ApiUrls.BASE_URL + ApiUrls.STRIPE_PRODUCT_ODER_AMMOUNT,
    );
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final json = jsonEncode(data);
    print("json---> ${json}");
    final response = await http.post(url, headers: headers, body: json);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');

    //Response and converter
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    return jsonResponse;
  }
}
