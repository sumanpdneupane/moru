import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/Routes.dart';
import 'package:moru/custom_widgets/ButtonWidget.dart';
import 'package:moru/custom_widgets/FooterWidget.dart';
import 'package:moru/custom_widgets/back_button/BackButtonWidget.dart';
import 'package:moru/custom_widgets/base_uis/BaseUIWidget.dart';
import 'package:moru/utils/CustomColors.dart';

class MAppoinmentDoneScreen extends StatefulWidget {
  const MAppoinmentDoneScreen({Key? key}) : super(key: key);

  @override
  State<MAppoinmentDoneScreen> createState() => _MAppoinmentDoneScreenState();
}

class _MAppoinmentDoneScreenState extends State<MAppoinmentDoneScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return BaseUIWidget(
      header: Container(
        width: width * 0.87,
        child: BackButtonWidget(
          onTap: () {
            Routes.pushNamedAndRemoveUntil(context, Routes.HOME_PAGE);
          },
          localeText: "waiting_room",
        ),
      ),
      // child: InstructionMainBody(
      //   botombtn: Container(),
      //   innerbody: Container(), //innerBody(context),
      // ),
      child: Container(),
      bottomSheet: FooterWidget(
        children: [
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/case_submitted.png',
              height: 120,
            ),
          ),
          SizedBox(height: 64),
          Container(
            width: width * 0.87,
            child: Text(
              'The report will be sent to you shortly.',
              textAlign: TextAlign.center,
              style: GoogleFonts.syne(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 84),
          ButtonWidget(
            name: "Track Report",
            height: 50,
            width: width * 0.87,
            fontSize: 15,
            backgroundColor: CustomColors.primarycolor,
            textColor: Colors.white,
            onTap: () {
              Routes.pushNamedAndRemoveUntil(context, Routes.HOME_PAGE);
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget innerBody(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/case_submitted.png',
            height: 120,
          ),
        ),
        SizedBox(height: 32),
        Text(
          'The report will be sent to you shortly ',
          textAlign: TextAlign.center,
          style: GoogleFonts.syne(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
