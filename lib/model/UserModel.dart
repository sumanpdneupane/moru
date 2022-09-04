import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  String? uid;
  String? fullname;
  String? email;
  String? role;
  DateTime? createdDate;

  UserModel(
    this.uid,
    this.fullname,
    this.email,
    this.role,
    this.createdDate,
  );

  UserModel copyWith({
    String? uid,
    String? fullname,
    String? email,
    String? role,
    DateTime? createdDate,
  }) {
    return UserModel(
        this.uid = uid ?? this.uid,
        this.fullname = fullname ?? this.fullname,
        this.email = email ?? this.email,
        this.role = role ?? this.role,
        this.createdDate = createdDate ?? this.createdDate);
  }

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

class UserViewModel with ChangeNotifier {
  UserModel _model = UserModel("", "", "", "", null);

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
