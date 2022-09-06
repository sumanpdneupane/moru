import 'package:moru/services/auth/AuthenticationApi.dart';
import 'package:moru/services/cases/CasesApi.dart';
import 'package:moru/services/payment/PaymentApi.dart';
import 'package:moru/services/user/UserApi.dart';

class Repository {
  AuthenticationApi authentication = AuthenticationApi();
  PaymentApi paymentApi = PaymentApi();
  UserApi users = UserApi();
  CasesApi cases = CasesApi();

}
