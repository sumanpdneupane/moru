import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moru/firebase/FirebaseInterface.dart';
import 'package:moru/model/CaseModel.dart';
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

  Future<List<CaseModel>> getByUserId({
    required String? userId,
  }) async {
    //Here role is patient/admin
    try {
      final usersColl = getInstance.collection("cases");
      final QuerySnapshot snapshot =
          await usersColl.where("createdBy", isEqualTo: userId).get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) {
          Map data = doc.data() as Map;
          return new CaseModel.fromJson(doc.id, data);
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      Commons.consoleLog("CasesApi::post----> ${e}");
      return [];
    }
  }
}
