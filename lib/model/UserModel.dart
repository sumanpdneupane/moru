import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid = "";
  String fullname = "";
  String email = "";
  String role = "";
  DateTime? createdDate = null;

  UserModel(
    this.uid,
    this.fullname,
    this.role,
    this.createdDate,
  );

  UserModel.fromJson(String uid, Map<dynamic, dynamic> json) {
    this.uid = uid;
    if (json != null && json.length > 0) {
      this.fullname = json["fullname"];
      this.email = json["email"];
      this.role = json["role"];
      var createdDate = json['createdDate'] as Timestamp;
      this.createdDate = createdDate != null ? createdDate.toDate() : null;
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map();
    data["fullname"] = fullname;
    data["email"] = email;
    data["createdDate"] = createdDate;
    data["role"] = role;
    return data;
  }
}
