import 'package:moru/firebase/FirebaseInterface.dart';
import 'package:moru/model/UserModel.dart';
import 'package:moru/utils/Commons.dart';

class UserApi extends FirebaseInterface {
  Future<bool> createUserProfile({
    required String uid,
    required String fullname,
    required String email,
    required DateTime createdDate,
  }) async {
    //Here role is patient/admin
    Map<String, dynamic> data = Map();
    data["fullName"] = fullname;
    data["email"] = email;
    data["createdDate"] = createdDate;
    data["role"] = "patient";
    try {
      final usersColl = getInstance.collection("users");
      await usersColl.doc(uid).set(data, setOptions);
      return true;
    } catch (e) {
      Commons.consoleLog("UserApi::createUserProfile----> ${e}");
      return false;
    }
  }

  Future<UserModel?> getCurrentUserInfo({
    required String? userId,
  }) async {
    try {
      final usersColl = getInstance.collection("users");
      var document = await usersColl.doc(userId).get();
      if (document.exists) {
        Map data = document.data() as Map;
        UserModel model = UserModel.fromJson(document.id, data);
        return model;
      }
    } catch (e) {
      Commons.consoleLog("UserApi::createUserProfile----> ${e}");
    }
    return null;
  }
}
