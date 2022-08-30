import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/custom_widgets/InputTextField.dart';
import 'package:moru/custom_widgets/MyInputField.dart';
import 'package:moru/uis/mobile/MMainScreen.dart';
import 'package:moru/uis/mobile/checkups/widgets/CheckupStyleWidget.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:moru/utils/MoruIcons.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MCheckupScreen extends StatelessWidget {
  const MCheckupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MMainScreen(
    //   child: CheckupBody(),
    //   selectedIndex: 1,
    // );
    return CheckupBody();
  }
}

class CheckupBody extends StatelessWidget {
  CheckupBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return ResponsiveBuilder(
      builder: (context, SizingInformation) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Container(
              alignment: Alignment.center,
              child: LocaleText(
                "checkup",
                style: GoogleFonts.syne(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 32),
            // InputTextField(
            //   heading: "Email",
            //   hintText: 'Search checkups',
            //   prefixicon: Image.asset(
            //     'assets/icons/search.png',
            //   ),
            //   width: width * 0.87,
            // ),
            // SizedBox(height: 16),
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
          ],
        );
      },
    );
  }
}
