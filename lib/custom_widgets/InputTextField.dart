import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/utils/CustomColors.dart';

class InputTextField extends StatelessWidget {
  String heading;
  String hintText;
  double width;
  Widget? prefixicon;
  Widget? suffixicon;
  int? maxLines;
  TextEditingController? controller;

  InputTextField({
    Key? key,
    required this.heading,
    required this.hintText,
    required this.width,
    required this.controller,
    this.prefixicon,
    this.suffixicon,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //
    //       ],
    //     ),
    //   ],
    // );
    double topP = maxLines! > 1 ? 16 : 8;
    double bottomP = maxLines! > 1 ? 16 : 8;

    return Container(
      width: width,
      child: SizedBox(
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: prefixicon,
            suffixIcon: suffixicon,
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide.none,
            ),
            fillColor: CustomColors.inputfillColor.withOpacity(0.07),
            filled: true,
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 15.0,
              color: Color.fromARGB(255, 156, 154, 154),
            ),
            contentPadding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
