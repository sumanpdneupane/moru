import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moru/uis/mobile/MMainScreen.dart';
import 'package:moru/uis/mobile/forgot_password/MForgotPasswordScreen.dart';
import 'package:moru/uis/mobile/home/MHomeScreen.dart';
import 'package:moru/uis/mobile/login/MLoginScreen.dart';
import 'package:moru/uis/mobile/signup/MSignupScreen.dart';
import 'package:moru/uis/mobile/splash/MSplashScreen.dart';

class Routes {
  static const String SPLASH_PAGE = "MSplashScreen";
  static const String LOGIN_PAGE = "MLoginPage";
  static const String SIGNUP_PAGE = "MSignUpPage";
  static const String HOME_PAGE = "MHomePage";
  static const String FORGOT_PAGE = "MForgotPasswordScreen";


  static Route<dynamic>? generateRoutes(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case SPLASH_PAGE:
        return _MaterialPageRoute(MSplashScreen());
      case LOGIN_PAGE:
        return _MaterialPageRoute(MLoginScreen());
      case SIGNUP_PAGE:
        return _MaterialPageRoute(MSignupScreen());
      case FORGOT_PAGE:
        return _MaterialPageRoute(MForgotPasswordScreen());
      case HOME_PAGE:
        return _MaterialPageRoute(MHomeScreen());
      default:
        MSplashScreen();
    }
  }

  static _MaterialPageRoute(Widget widget) {
    return MaterialPageRoute(builder: (_) => widget);
  }

  static pushNamed(context, routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  static pushNamedWithArguments(
      context, routName, Map<String, dynamic> arguments) {
    Navigator.of(context).pushNamed(routName, arguments: arguments);
  }

  static popAndPushNamed(context, routeName) {
    Navigator.of(context).popAndPushNamed(routeName);
  }

  static pushReplacementNamed(context, routeName) {
    Navigator.of(context).pushReplacementNamed(routeName);
  }

  static pop(context) {
    Navigator.of(context).pop();
  }

  static String initialRoute() {
    return Routes.SPLASH_PAGE;
  }
}