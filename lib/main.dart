import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:moru/Routes.dart';
import 'package:moru/model/UserModel.dart';
import 'package:moru/utils/Constants.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  //runApp(const MyApp());
  // runZonedGuarded<Future<void>>(
  //   () async {
  //     WidgetsFlutterBinding.ensureInitialized();
  //     await Locales.init(['en', 'ar']);
  //     await Firebase.initializeApp();
  //     FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  //
  //     runApp(MyApp());
  //   },
  //   (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
  // );

  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['en', 'ar']);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Check which route mobile or website
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false;

    return LocaleBuilder(builder: (locale) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: UserViewModel()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          localizationsDelegates: Locales.delegates,
          supportedLocales: Locales.supportedLocales,
          locale: locale,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: Routes.generateRoutes,
          initialRoute: Routes.initialRoute(),
          navigatorKey: Constants.navigatorKey,
          builder: EasyLoading.init(),
        ),
      );
    });
  }
}

/**
 *
 * flutter run -d chrome
 * flutter run -d chrome --web-renderer html // to run the app
 * flutter build web --web-renderer html --release // to generate a production build
 */
