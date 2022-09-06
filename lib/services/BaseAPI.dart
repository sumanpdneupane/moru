import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:moru/services/ApiUrls.dart';

class BaseAPI {
  //Headers
  // Map<String, String> getHeaders({required LoginModel loginModel}) {
  //   Map<String, String>? headers = new Map();
  //   // headers["Content-Type"] = "application/json";
  //   // headers["Accept"] = "application/json";
  //   headers["Authorization"] = "Bearer ${loginModel.data!.accessToken}";
  //   return headers;
  // }

  //API URL
  urlForGetApi({
    required String toFetchUrl,
    required Map<String, dynamic> requestBody,
  }) {
    var url = Uri.https(
      ApiUrls.BASE_URL.replaceAll("https://", ""),
      toFetchUrl,
      requestBody,
    );
    return url;
  }

  Future<Map<String, dynamic>> httpGetRequest({
    required Uri url,
    required Map<String, String> headers,
  }) async {
    //Hit api
    var response = await http.get(url, headers: headers);
    //print('Response body${url}-------->:\n ${response.body}');

    //Response and converter
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    return jsonResponse;
  }

  Future<Map<String, dynamic>> httpPostRequest({
    required String destinationUrl,
    required Map<String, dynamic> body,
  }) async {
    print("ApiUrl----------> ${body}");
    //Hit api
    var url = Uri.https(
      ApiUrls.BASE_URL.replaceAll("https://", ""),
      destinationUrl,
      //body,
    );
    print("ApiUrl----------> ${url}");

    Map<String, String>? headers = new Map();
    headers["Content-Type"] = "application/json";
    headers["Accept"] = "application/json";

    var response = await http.post(url, body: body, headers: headers);
    print('Response body${url}-------->:\n ${response.body}');

    //Response and converter
    // var jsonResponse =
    //     convert.jsonDecode(response.body) as Map<String, dynamic>;

    return {};
  }
}
