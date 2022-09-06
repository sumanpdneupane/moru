import 'package:moru/firebase/FirebaseInterface.dart';
import 'package:moru/utils/Commons.dart';

class CasesApi extends FirebaseInterface {
  Future<bool> post({
    Map<String, dynamic>? data,
  }) async {
    //Here role is patient/admin
    try {
      final casesColl = getInstance.collection("cases");
      await casesColl.add(data!);
      return true;
    } catch (e) {
      Commons.consoleLog("CasesApi::post----> ${e}");
      return false;
    }
  }
}