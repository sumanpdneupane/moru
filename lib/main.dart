import 'dart:async';

//import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:moru/Routes.dart';
import 'package:moru/libraries/WebImageCapturePage.dart';
import 'package:moru/model/AppViewModel.dart';
import 'package:moru/model/UserModel.dart';
import 'package:moru/utils/Constants.dart';
import 'package:provider/provider.dart';
import 'package:universal_io/prefer_universal/io.dart';

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
  //cameras = await availableCameras();
  await Locales.init(['en', 'ar']);
  // await Firebase.initializeApp(
  //   options:
  // );
  if (Platform.isAndroid || Platform.isIOS) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          // apiKey: "AIzaSyBoIq1GbM-DMiWVZdC9LKxEmtW43htkaF0",
          // appId: "1:524010047131:web:cd294471a31292b995683e",
          // messagingSenderId: "524010047131",
          // projectId: "web-rtc-6f95e",
          apiKey: "AIzaSyBoIq1GbM-DMiWVZdC9LKxEmtW43htkaF0",
          authDomain: "web-rtc-6f95e.firebaseapp.com",
          databaseURL: "https://web-rtc-6f95e.firebaseio.com",
          projectId: "web-rtc-6f95e",
          storageBucket: "web-rtc-6f95e.appspot.com",
          messagingSenderId: "524010047131",
          appId: "1:524010047131:web:cd294471a31292b995683e",
          measurementId: "G-6S9E7LTG34"),
    );
  }

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
          ChangeNotifierProvider.value(value: AppViewModel()),
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
 * flutter run -d chrome --web-hostname localhost --web-port 54537
 * flutter build web --web-renderer html --release // to generate a production build
 */
