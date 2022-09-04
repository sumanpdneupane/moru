import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moru/Routes.dart';
import 'package:moru/model/UserModel.dart';
import 'package:moru/services/Repository.dart';
import 'package:moru/utils/Commons.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:provider/provider.dart';

class MSplashScreen extends StatefulWidget {
  const MSplashScreen({Key? key}) : super(key: key);

  @override
  State<MSplashScreen> createState() => _MSplashScreenState();
}

class _MSplashScreenState extends State<MSplashScreen> {
  Repository repository = Repository();

  Future<bool> loginUser({required String? uid}) async {
    UserModel? userModel =
        await repository.users.getCurrentUserInfo(userId: uid);
    if (userModel != null) {
      Provider.of<UserViewModel>(context, listen: false).update(userModel);
      return true;
    } else {
      return false;
    }
  }

  Future<void> silentLogin() async {
    String? userId = await repository.authentication.silentLogin();
    if (userId == "") {
      Routes.popAndPushNamed(context, Routes.LOGIN_PAGE);
    } else {
      bool result = await loginUser(uid: userId);

      if (result) {
        Routes.popAndPushNamed(context, Routes.HOME_PAGE);
      } else {
        Routes.popAndPushNamed(context, Routes.LOGIN_PAGE);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    silentLogin();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 700), () {
      //Check Login here LOGIN_PAGE or HOME_PAGE
      //Routes.popAndPushNamed(context, Routes.LOGIN_PAGE);
    });

    return Scaffold(
      backgroundColor: CustomColors.primarycolor,
      body: Center(
        child: SvgPicture.asset(
          'assets/logo.svg',
          color: Colors.white,
          height: 50,
          width: 50,
        ),
      ),
    );
  }
}
