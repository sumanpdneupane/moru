import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCheckBox extends StatelessWidget {
  String text;
  double width;
  bool? value;
  Color activeColor;
  Function(bool?) onChanged;

  MyCheckBox({
    Key? key,
    required this.text,
    required this.width,
    this.value = false,
    required this.activeColor,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 24.0,
          width: 24.0,
          child: Checkbox(
            value: value,
            checkColor: Colors.white,
            activeColor: activeColor,
            onChanged: (val) {
              onChanged(val);
            },
          ),
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.syne(),
        ),
      ],
    );
  }
}
