import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moru/libraries/WebImageCapturePage.dart';
import 'package:moru/uis/mobile/MMainScreen.dart';
import 'package:moru/uis/mobile/checkups/MCheckupScreen.dart';
import 'package:moru/uis/mobile/checkups/pages/MCheckupReadyScreen.dart';
import 'package:moru/uis/mobile/forgot_password/MForgotPasswordScreen.dart';
import 'package:moru/uis/mobile/home/MHomeScreen.dart';
import 'package:moru/uis/mobile/instructions/MInstructionScreen.dart';
import 'package:moru/uis/mobile/instructions/pages/MAppoinmentDoneScreen.dart';
import 'package:moru/uis/mobile/instructions/pages/MPaymentScreen.dart';
import 'package:moru/uis/mobile/instructions/pages/MQuestionnarie1Screen.dart';
import 'package:moru/uis/mobile/instructions/pages/MQuestionnarie2Screen.dart';
import 'package:moru/uis/mobile/instructions/pages/MQuestionnarie3Screen.dart';
import 'package:moru/uis/mobile/instructions/pages/MQuestionnarie4Screen.dart';
import 'package:moru/uis/mobile/instructions/pages/MQuestionnarie5Screen.dart';
import 'package:moru/uis/mobile/instructions/pages/MUploadImageScreen.dart';
import 'package:moru/uis/mobile/login/MLoginScreen.dart';
import 'package:moru/uis/mobile/signup/MSignupScreen.dart';
import 'package:moru/uis/mobile/splash/MSplashScreen.dart';

class Routes {
  static const String SPLASH_PAGE = "MSplashScreen";
  static const String LOGIN_PAGE = "MLoginPage";
  static const String SIGNUP_PAGE = "MSignUpPage";
  static const String FORGOT_PAGE = "MForgotPasswordScreen";
  static const String HOME_PAGE = "MHomePage";
  static const String CHECKUP_READY_PAGE = "MCheckupReadyScreen";
  static const String INSTRUCTION_PAGE = "MInstructionScreen";
  static const String UPLOAD_IMAGE_PAGE = "MUploadImageScreen";
  static const String QUESTIONNARE_1_PAGE = "MQuestionnarie1Screen";
  static const String QUESTIONNARE_2_PAGE = "MQuestionnarie2Screen";
  static const String QUESTIONNARE_3_PAGE = "MQuestionnarie3Screen";
  static const String QUESTIONNARE_4_PAGE = "MQuestionnarie4Screen";
  static const String QUESTIONNARE_5_PAGE = "MQuestionnarie5Screen";
  static const String PAYMENT_PAGE = "MPaymentScreen";
  static const String APPOINMENT_DONE_PAGE = "MAppoinmentDoneScreen";
  static const String WEB_CAMERA_PAGE = "WebImageCapturePage";

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
        return _MaterialPageRoute(
            MMainScreen(selectedIndex: 0, child: Container()));
      case CHECKUP_READY_PAGE:
        return _MaterialPageRoute(MCheckupReadyScreen());
      case INSTRUCTION_PAGE:
        return _MaterialPageRoute(MInstructionScreen());
      case UPLOAD_IMAGE_PAGE:
        return _MaterialPageRoute(MUploadImageScreen());
      case QUESTIONNARE_1_PAGE:
        return _MaterialPageRoute(MQuestionnarie2Screen());
      case QUESTIONNARE_2_PAGE:
        return _MaterialPageRoute(MQuestionnarie1Screen());
      case QUESTIONNARE_3_PAGE:
        return _MaterialPageRoute(MQuestionnarie3Screen());
      case QUESTIONNARE_4_PAGE:
        return _MaterialPageRoute(MQuestionnarie4Screen());
      case QUESTIONNARE_5_PAGE:
        return _MaterialPageRoute(MQuestionnarie5Screen());
      case PAYMENT_PAGE:
        return _MaterialPageRoute(MPaymentScreen());
      case APPOINMENT_DONE_PAGE:
        return _MaterialPageRoute(MAppoinmentDoneScreen());
      // case WEB_CAMERA_PAGE:
      //   return _MaterialPageRoute(WebImageCapturePage());
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

  static pushNamedAndRemoveUntil(context, routeName) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
    );
  }

  static pop(context) {
    Navigator.of(context).pop();
  }

  static popUntil(context) {
    Navigator.of(context).popUntil((route) => false);
  }

  static String initialRoute() {
    return Routes.HOME_PAGE;
  }
}
