import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final String name;
  final double height;
  final double width;
  final double fontSize;
  final Color backgroundColor;
  final Color textColor;
  final String prefixIconPath;
  final Function() onTap;

  const ButtonWidget({
    Key? key,
    required this.name,
    required this.height,
    required this.width,
    required this.fontSize,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
    this.prefixIconPath = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: backgroundColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixIconPath == ""
                ? Container()
                : Container(
                    margin: EdgeInsets.only(right: 16),
                    child: Image.asset(
                      "${prefixIconPath}",
                      width: fontSize + 8,
                      height: fontSize + 8,
                    ),
                  ),
            Text(
              name,
              style: GoogleFonts.syne(
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
                color: textColor == null ? Colors.white : textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//  @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         onTap();
//       },
//       child: Container(
//         width: width,
//         height: height,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           color: backgroundColor,
//         ),
//         child: Center(
//           child: Text(
//             name,
//             style: GoogleFonts.syne(
//               fontSize: fontSize,
//               fontWeight: FontWeight.w700,
//               color: Color(0xffFFFFFF),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
