import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyWrapButton extends StatelessWidget {
  double height, width, fontSize;
  Color boxcolor, fontcolor;
  String btntxt;
  FontWeight fontWeight;

  MyWrapButton({
    Key? key,
    required this.boxcolor,
    this.height = 50,
    this.fontSize = 12,
    required this.btntxt,
    this.width = 0.25,
    required this.fontcolor,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width * width,
      decoration: BoxDecoration(
        color: boxcolor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Flexible(
        child: FractionallySizedBox(
          widthFactor: 0.7,
          child: Center(
            child: FittedBox(
              child: Text(
                btntxt,
                style: GoogleFonts.syne(
                  fontSize: 16,
                  color: fontcolor,
                  fontWeight: fontWeight,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}