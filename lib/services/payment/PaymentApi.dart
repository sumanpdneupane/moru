import 'package:moru/services/ApiUrls.dart';
import 'package:moru/services/BaseAPI.dart';

class PaymentApi extends BaseAPI {
  Future getProduct(String priceId) async {
    Map<String, dynamic> map = Map();
    map["data"] = {"id": priceId}.toString();

    // var data = {
    //   "data": {"id": priceId}
    // };
    await httpPostRequest(
      destinationUrl: ApiUrls.GET_PRODUCT_ODER_AMMOUNT,
      body: map,
    );
  }
}
