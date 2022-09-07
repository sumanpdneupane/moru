import 'package:dartz/dartz.dart' as dart;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/Routes.dart';
import 'package:moru/custom_widgets/ButtonWidget.dart';
import 'package:moru/custom_widgets/MyCheckBox.dart';
import 'package:moru/custom_widgets/MyInputField.dart';
import 'package:moru/custom_widgets/MyWrapButton.dart';
import 'package:moru/model/UserModel.dart';
import 'package:moru/services/Repository.dart';
import 'package:moru/utils/Commons.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:provider/provider.dart';

class MSignupScreen extends StatefulWidget {
  const MSignupScreen({Key? key}) : super(key: key);

  @override
  State<MSignupScreen> createState() => _MSignupScreenState();
}

class _MSignupScreenState extends State<MSignupScreen> {
  bool? Value = false;
  bool? dValue = false;
  Repository repository = Repository();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController re_passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

  Future<bool> signup() async {
    if (fullNameController.text.isEmpty) {
      Commons.toastMessage(context, "Please enter your full name.");
      return false;
    } else if (emailController.text.isEmpty) {
      Commons.toastMessage(context, "Please enter email address");
      return false;
    } else if (passwordController.text.isEmpty) {
      Commons.toastMessage(context, "Please enter password.");
      return false;
    } else if (re_passwordController.text.isEmpty) {
      Commons.toastMessage(context, "Please re-enter password.");
      return false;
    } else if (passwordController.text.trim() !=
        re_passwordController.text.trim()) {
      Commons.toastMessage(
        context,
        "Comfirm password does not matched with password.",
      );
      return false;
    } else {
      UserCredential? userCredential =
          await repository.authentication.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        //context: context,
      );

      //create user profile
      if (userCredential == null) {
        Commons.toastMessage(
          context,
          "Account could not created or already created.",
        );
        return false;
      } else {
        bool result = await repository.users.createUserProfile(
          uid: userCredential.user!.uid,
          fullname: fullNameController.text.trim(),
          email: userCredential.user!.email!,
          createdDate: userCredential.user!.metadata.creationTime!,
        );
        if (!result) {
          Commons.toastMessage(context, "Account could not created.");
          return false;
        } else {
          Commons.toastMessage(context, "Account created successfully.");
          return await loginUser(uid: userCredential.user!.uid);
        }
      }
    }
  }

  Future<bool> loginUser({required String? uid}) async {
    UserModel? userModel =
        await repository.users.getCurrentUserInfo(userId: uid);
    if (userModel != null) {
      Provider.of<UserViewModel>(context, listen: false).update(userModel);
      repository.saveUserIdToLocal(uid: uid!);
      //Commons.toastMessage(context, "Login successully");
      return true;
    } else {
      Commons.toastMessage(context, "Failed to Login");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.87;

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Container(
                  height: 100,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/logo.svg',
                      width: 200,
                    ),
                  ),
                ),
                Container(
                  width: width,
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.syne(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                MyInputField(
                  heading: "Full Name",
                  controller: fullNameController,
                  width: width,
                ),
                SizedBox(
                  height: 15,
                ),
                MyInputField(
                  heading: "Email",
                  controller: emailController,
                  width: width,
                ),
                SizedBox(
                  height: 15,
                ),
                MyInputField(
                  heading: "Password",
                  controller: passwordController,
                  obscureText: true,
                  width: width,
                ),
                SizedBox(
                  height: 15,
                ),
                MyInputField(
                  heading: "Confirm Password",
                  controller: re_passwordController,
                  obscureText: true,
                  width: width,
                ),
                // SizedBox(
                //   height: 15,
                // ),
                // Container(
                //   width: width,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Container(
                //         child: Text(
                //           "Gender",
                //           style: GoogleFonts.syne(
                //             fontSize: 16,
                //             color: CustomColors.inputfillColor,
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         height: 8,
                //       ),
                //       Row(
                //         children: [
                //           MyWrapButton(
                //             boxcolor: CustomColors.primarycolor,
                //             btntxt: "Male",
                //             fontcolor: Colors.white,
                //             height: 40,
                //           ),
                //           SizedBox(
                //             width: 18,
                //           ),
                //           MyWrapButton(
                //             boxcolor:
                //                 CustomColors.inputfillColor.withOpacity(0.07),
                //             btntxt: "Female",
                //             fontcolor: CustomColors.primarycolor,
                //             height: 40,
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // MyCheckBox(
                //   text: 'Accept terms and conditions',
                //   width: width,
                //   value: Value,
                //   activeColor: CustomColors.primarycolor,
                //   onChanged: (val) {
                //     setState(() {
                //       Value = val!;
                //     });
                //   },
                // ),
                // SizedBox(
                //   height: 8,
                // ),
                // MyCheckBox(
                //   text: 'Privacy Policy',
                //   width: width,
                //   value: dValue,
                //   activeColor: CustomColors.primarycolor,
                //   onChanged: (val) {
                //     setState(() {
                //       dValue = val!;
                //     });
                //   },
                // ),
                SizedBox(
                  height: 40,
                ),
                ButtonWidget(
                  name: "Sign Up",
                  height: 50,
                  width: width,
                  fontSize: 19,
                  backgroundColor: CustomColors.primarycolor,
                  textColor: Colors.white,
                  onTap: () async {
                    EasyLoading.show(status: 'Creating your profile...');
                    bool result = await signup();
                    EasyLoading.dismiss();
                    if (result) {
                      Routes.popAndPushNamed(context, Routes.HOME_PAGE);
                    }
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
