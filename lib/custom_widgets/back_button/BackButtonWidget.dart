import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/utils/CustomColors.dart';

class BackButtonWidget extends StatelessWidget {
  final Function() onTap;
  final String localeText;

  BackButtonWidget({
    Key? key,
    required this.onTap,
    this.localeText = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        GestureDetector(
          onTap: (){
            onTap();
          },
          child: Container(
            height: 36,
            width: 36,
            //padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              //color: Colors.white,
              border: Border.all(
                color: CustomColors.primarycolor1.withOpacity(0.35),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.arrow_back),
          ),
        ),
        localeText == ""
            ? Container()
            : Container(
                width: width,
                height: 36,
                //padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                child: LocaleText(
                  localeText,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.syne(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ],
    );
  }
}
