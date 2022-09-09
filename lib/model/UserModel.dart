import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  String? uid;
  String? fullname;
  String? email;
  String? role;
  String? photo;
  DateTime? createdDate;
  String? licensedFrom;
  String? collegeName;
  String? collegeAddress;

  UserModel(
    this.uid,
    this.fullname,
    this.email,
    this.role,
    this.createdDate,
    this.photo,
    this.licensedFrom,
    this.collegeName,
    this.collegeAddress,
  );

  UserModel copyWith({
    String? uid,
    String? fullname,
    String? email,
    String? role,
    String? imageUrl,
    DateTime? createdDate,
    String? licensedFrom,
    String? collegeName,
    String? collegeAddress,
  }) {
    return UserModel(
        this.uid = uid ?? this.uid,
        this.fullname = fullname ?? this.fullname,
        this.email = email ?? this.email,
        this.role = role ?? this.role,
        this.createdDate = createdDate ?? this.createdDate,
        this.photo = imageUrl ?? this.photo,
        this.licensedFrom = licensedFrom ?? this.licensedFrom,
        this.collegeName = collegeName ?? this.collegeName,
        this.collegeAddress = collegeAddress ?? this.collegeAddress);
  }

  UserModel.fromJson(String uid, Map<dynamic, dynamic> json) {
    this.uid = uid;
    if (json != null && json.length > 0) {
      if (json.containsKey("fullName")) {
        this.fullname = json["fullName"];
      }
      if (json.containsKey("fullname")) {
        this.fullname = json["fullname"];
      }
      this.email = json["email"];
      this.role = json["role"];
      var createdDate = json['createdDate'] as Timestamp;
      this.createdDate = createdDate != null ? createdDate.toDate() : null;
      this.photo = json.containsKey("photo") ? json['photo'] : null;
      this.licensedFrom = json["licensedFrom"];
      this.collegeName = json["collegeName"];
      this.collegeAddress = json["collegeAddress"];
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map();
    data["fullName"] = fullname;
    data["email"] = email;
    data["createdDate"] = createdDate;
    data["role"] = role;
    data["photo"] = photo;
    return data;
  }
}

class UserViewModel with ChangeNotifier {
  UserModel _model = UserModel("", "", "", "", null, "", "", "", "");

  void update(UserModel userModel) {
    _model = userModel;
    notifyListeners();
  }

  UserModel getModel() {
    return _model;
  }
}

//TODO: provider
//https://www.geeksforgeeks.org/flutter-using-nested-models-and-providers/
//https://www.freecodecamp.org/news/provider-pattern-in-flutter/

//TODO: to update data
//1.  UserNameWidget(),
//       ButtonWidget(
//         name: "Update",
//         height: 50,
//         width: width,
//         fontSize: 19,
//         backgroundColor: CustomColors.primarycolor,
//         textColor: Colors.white,
//         onTap: () {
//           var userVM = Provider.of<UserViewModel>(context, listen: false);
//           var model = userVM.getModel();
//           userVM.update(model.copyWith(fullname: "Hari Prasad"));
//         },
//       ),
//2.   Provider.of<UserViewModel>(context, listen: false).update(userModel);

//TODO: to show data
//class UserNameWidget extends StatelessWidget {
//   const UserNameWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UserViewModel>(
//       builder: (ctx, data, Widget? child) {
//         return Text("${data.getModel().fullname}");
//       },
//     );
//   }
// }
