import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moru/Routes.dart';
import 'package:moru/utils/CustomColors.dart';


class MSplashScreen extends StatefulWidget {
  const MSplashScreen({Key? key}) : super(key: key);

  @override
  State<MSplashScreen> createState() => _MSplashScreenState();
}

class _MSplashScreenState extends State<MSplashScreen> {
  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(milliseconds: 700), () {
      //Check Login here LOGIN_PAGE or HOME_PAGE
      Routes.popAndPushNamed(context, Routes.LOGIN_PAGE);
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
