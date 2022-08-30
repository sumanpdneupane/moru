import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/uis/mobile/MMainScreen.dart';
import 'package:moru/uis/mobile/checkups/widgets/CheckupStyleWidget.dart';
import 'package:moru/uis/mobile/home/widgets/CheckupWidget.dart';
import 'package:moru/uis/mobile/home/widgets/HowItWorkWidget.dart';
import 'package:moru/uis/mobile/home/widgets/TrackWidgets.dart';
import 'package:moru/uis/mobile/home/widgets/UpcomingCheckupWidget.dart';
import 'package:moru/uis/mobile/home/widgets/WelcomeWidget.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:moru/utils/MoruIcons.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MHomeScreen extends StatefulWidget {
  const MHomeScreen({Key? key}) : super(key: key);

  @override
  State<MHomeScreen> createState() => _MHomeScreenState();
}

class _MHomeScreenState extends State<MHomeScreen> {
  @override
  Widget build(BuildContext context) {
    // return MMainScreen(
    //   child: SafeArea(
    //     child: HomePgeBody(),
    //   ),
    //   selectedIndex: 0,
    // );
    return HomePgeBody();
  }
}

class HomePgeBody extends StatelessWidget {
  const HomePgeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ResponsiveBuilder(builder: (context, SizingInformation) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4),
          WelcomeWidget(),
          SizedBox(height: 32),
          HowItWorkWidget(),
          Visibility(
            visible: false,
            child: SizedBox(height: 24),
          ),
          Visibility(
            visible: false,
            child: UpcomingCheckupWidget(),
          ),
          SizedBox(
            height: 32,
          ),
          LocaleText(
            'checkup1',
            style: GoogleFonts.syne(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          CheckupWidget(),
          SizedBox(
            height: 32,
          ),
          LocaleText(
            'track',
            style: GoogleFonts.syne(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          // TrackWidgets(),
          // SizedBox(
          //   height: 12,
          // ),
          // TrackWidgets(
          //   boxcolor: CustomColors.orangeshade,
          //   icon: Moru.teeth_add,
          //   lcltxt: 'emergency',
          //   lcltxt2: 'report_ready',
          //   lcltxt3: '14th_of_may_2022',
          //   circlecolor: CustomColors.darkred,
          // ),
          CheckupStyleWidget(
            date: "14th_of_May_2022",
            title: "full_assessment",
            title2: "in_progress",
            dotColor: CustomColors.yellow,
          ),
          SizedBox(height: 8),
          CheckupStyleWidget(
            date: "10th_of_aprill_2022",
            title: "single_issue",
            title2: "need_update",
            boxcolor: CustomColors.orangeshade,
            icon: Moru.teeth_calen,
            dotColor: CustomColors.red,
          ),
          SizedBox(height: 8),
          CheckupStyleWidget(
            date: "14th_of_May_2022",
            title: "Emergency",
            title2: "report_ready",
            dotColor: CustomColors.green,
            icon: Moru.teeth_cross,
            showReport: true,
          ),
          SizedBox(height: 8),
          CheckupStyleWidget(
            date: "10th_of_aprill_2022",
            title: "emergency",
            title2: "report_ready",
            dotColor: CustomColors.green,
            icon: Moru.teeth_add,
            showReport: true,
          ),
          SizedBox(
            height: 48,
          ),
        ],
      );
    });
  }
}
