import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/utils/CustomColors.dart';

class MyInputField extends StatelessWidget {
  String heading;
  double width;
  Widget? suffixicon;
  TextEditingController? controller;

  MyInputField({
    Key? key,
    required this.heading,
    required this.width,
    required this.controller,
    this.suffixicon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: GoogleFonts.syne(
                fontSize: 16,
                color: CustomColors.inputfillColor,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: width,
              child: SizedBox(
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    suffixIcon: suffixicon,
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: CustomColors.inputfillColor.withOpacity(0.07),
                    filled: true,
                    hintStyle: const TextStyle(
                      fontSize: 15.0,
                      color: Color.fromARGB(255, 156, 154, 154),
                    ),
                    contentPadding: const EdgeInsets.only(left: 20, right: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
