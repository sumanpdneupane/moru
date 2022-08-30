import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/Routes.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:moru/utils/MoruIcons.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CheckupStyleWidget extends StatelessWidget {
  String date, title, title2;
  Color boxcolor, dotColor;
  bool showReport;
  IconData icon;

  CheckupStyleWidget({
    Key? key,
    required this.date,
    required this.title,
    required this.title2,
    this.boxcolor = CustomColors.primarycolor,
    this.dotColor = CustomColors.yellow,
    this.icon = Moru.smile,
    this.showReport = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ResponsiveBuilder(builder: (context, SizingInformation) {
      return GestureDetector(
        onTap: () {
          Routes.pushNamed(context, Routes.CHECKUP_READY_PAGE);
        },
        child: SizedBox(
          width: width,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            width: width,
            child: Container(
              margin: EdgeInsets.only(left: 0, right: 0),
              child: Row(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                          color: boxcolor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          icon,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LocaleText(
                            date,
                            style: GoogleFonts.syne(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 10,
                                color: dotColor,
                              ),
                              SizedBox(width: 5),
                              LocaleText(
                                title2,
                                style: GoogleFonts.syne(
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: 15),
                    ],
                  ),
                  showReport
                      ? Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 42,
                              width: 42,
                              //alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: CustomColors.primarycolorLight,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //padding: EdgeInsets.all(8),
                              child: Image.asset(
                                'assets/icons/report.png',
                                width: 15,
                                height: 15,
                                color: CustomColors.primarycolor,
                              ),
                            ),
                          ),
                        )
                      : LocaleText(
                          'empty',
                          style: GoogleFonts.syne(
                            fontSize: 12,
                            color: Color(0xff6B779A),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
