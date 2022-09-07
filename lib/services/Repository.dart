import 'package:moru/services/auth/AuthenticationApi.dart';
import 'package:moru/services/cases/CasesApi.dart';
import 'package:moru/services/payment/PaymentApi.dart';
import 'package:moru/services/user/UserApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  AuthenticationApi authentication = AuthenticationApi();
  PaymentApi paymentApi = PaymentApi();
  UserApi users = UserApi();
  CasesApi cases = CasesApi();

  Future saveUserIdToLocal({required String uid}) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', uid);
  }

  Future<String> getUserIdFromLocal() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getString('userId') ?? "";
  }
}
