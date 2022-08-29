import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:moru/utils/MoruIcons.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TrackWidgets extends StatelessWidget {
  String lcltxt, lcltxt2, lcltxt3;
  Color boxcolor, circlecolor;
  IconData icon;

  TrackWidgets({
    Key? key,
    this.lcltxt = 'full_assessment',
    this.lcltxt2 = 'in_progress',
    this.lcltxt3 = '10th_of_aprill_2022',
    this.boxcolor = CustomColors.primarycolor,
    this.icon = Moru.smile,
    this.circlecolor = CustomColors.yellow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ResponsiveBuilder(
      builder: (context, SizingInformation) {
        return SizedBox(
          width: width * 0.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LocaleText(
                        lcltxt3,
                        style: GoogleFonts.syne(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.circle,
                            size: 10,
                            color: circlecolor,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          LocaleText(
                            lcltxt2,
                            style: GoogleFonts.syne(
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
              LocaleText(
                'empty',
                style: GoogleFonts.syne(),
              ),
            ],
          ),
        );
      },
    );
  }
}
