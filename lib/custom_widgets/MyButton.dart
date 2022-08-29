import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyButton extends StatelessWidget {
  double height, width;
  Color boxcolor, fontcolor;
  String btntxt;
  Function? ontap;
  MyButton({
    Key? key,
    this.boxcolor = Colors.white,
    this.height = 50,
    required this.btntxt,
    this.width = 100,
    this.fontcolor = CustomColors.orangeshade,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, SizingInformation) {
      return GestureDetector(
        onTap: (() {
          ontap!();
        }),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: boxcolor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: CustomColors.primarycolor,
            ),
          ),
          child: Flexible(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Center(
                child: LocaleText(
                  btntxt,
                  style: GoogleFonts.syne(
                    fontSize: SizingInformation.deviceScreenType ==
                        DeviceScreenType.desktop
                        ? 16
                        : 12,
                    color: fontcolor,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}