import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:moru/Routes.dart';
import 'package:moru/utils/Constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['en', 'ar']);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Check which route mobile or website

    return LocaleBuilder(builder: (locale) {
      return MaterialApp(
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
