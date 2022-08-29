import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/custom_widgets/MyButton.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:moru/utils/MoruIcons.dart';

class UpcomingCheckupWidget extends StatelessWidget {
  const UpcomingCheckupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: CustomColors.primarycolor2,
        border: Border.all(
          color: CustomColors.yellow,
          width: 3,
        ),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        runSpacing: 16,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                          color: CustomColors.yellow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Moru.teeth_add,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                      SizedBox(
                        width: 9,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LocaleText(
                            'upcoming_checkup',
                            style: GoogleFonts.syne(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.circle,
                                size: 7,
                                color: CustomColors.darkred,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              LocaleText(
                                '30_minute_left',
                                style: GoogleFonts.syne(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: MyButton(
                    height: 45,
                    ontap: () {
                      //Navigator.pushNamed(context, '/videochat');
                    },
                    btntxt: 'join',
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: MyButton(
                    btntxt: 'reschedule',
                    height: 45,
                    fontcolor: CustomColors.primarycolor,
                  ),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //     left: width * 0.03,
          //     right: width * 0.03,
          //   ),
          //   child: Container(
          //     width: 200,
          //     padding: EdgeInsets.only(
          //       left: width * 0.03,
          //       right: width * 0.03,
          //     ),
          //     child: Row(
          //       children: [
          //         Container(
          //           height: 50,
          //           width: 50,
          //           decoration: BoxDecoration(
          //             color: CustomColors.yellow,
          //             borderRadius: BorderRadius.circular(15),
          //           ),
          //           child: Icon(
          //             Moru.teeth_add,
          //             color: Colors.white,
          //           ),
          //         ),
          //         SizedBox(
          //           width: 9,
          //         ),
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             LocaleText(
          //               'upcoming_checkup',
          //               style: GoogleFonts.syne(
          //                 fontSize: 12,
          //                 fontWeight: FontWeight.w600,
          //                 color: Colors.white,
          //               ),
          //             ),
          //             SizedBox(
          //               height: 5,
          //             ),
          //             Row(
          //               crossAxisAlignment: CrossAxisAlignment.end,
          //               children: [
          //                 Icon(
          //                   Icons.circle,
          //                   size: 7,
          //                   color: CustomColors.darkred,
          //                 ),
          //                 SizedBox(
          //                   width: 5,
          //                 ),
          //                 LocaleText(
          //                   '30_minute_left',
          //                   style: GoogleFonts.syne(
          //                     fontSize: 10,
          //                     fontWeight: FontWeight.w400,
          //                     color: Colors.white,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     left: 8.0,
          //     right: 8,
          //   ),
          //   child: Container(
          //     //width: 300,
          //     padding: const EdgeInsets.only(
          //       left: 8.0,
          //       right: 8,
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         MyButton(
          //           ontap: () {
          //             //Navigator.pushNamed(context, '/videochat');
          //           },
          //           btntxt: 'join',
          //         ),
          //         SizedBox(
          //           width: 10,
          //         ),
          //         MyButton(
          //           btntxt: 'reschedule',
          //           width: 100,
          //           fontcolor: CustomColors.primarycolor,
          //         ),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
