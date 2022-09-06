import 'package:moru/services/auth/AuthenticationApi.dart';
import 'package:moru/services/payment/PaymentApi.dart';
import 'package:moru/services/user/UserApi.dart';

class Repository {
  AuthenticationApi authentication = AuthenticationApi();
  UserApi users = UserApi();
  PaymentApi paymentApi = PaymentApi();

}
