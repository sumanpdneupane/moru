import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/Routes.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:moru/utils/MoruIcons.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CheckupActionWidget extends StatelessWidget {
  String title, title2;
  Color boxcolor;
  IconData icon;

  CheckupActionWidget({
    Key? key,
    required this.title,
    required this.title2,
    this.boxcolor = CustomColors.primarycolor,
    this.icon = Moru.smile,
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
                          Text(
                            title,
                            style: GoogleFonts.syne(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
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
                  LocaleText(
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



class CheckupDoctorWidget extends StatelessWidget {
  String title, title2;
  Color boxcolor;
  IconData icon;
  String photo;

  CheckupDoctorWidget({
    Key? key,
    required this.title,
    required this.title2,
    required this.photo,
    this.boxcolor = CustomColors.primarycolor,
    this.icon = Moru.smile,
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
                      photo != null && photo != ""
                          ? Container(
                        height: 42,
                        width: 42,
                        //margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(photo),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                          : Container(),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.syne(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
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
                  LocaleText(
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
