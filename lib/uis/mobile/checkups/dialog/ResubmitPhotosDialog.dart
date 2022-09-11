import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/Routes.dart';
import 'package:moru/custom_widgets/ButtonWidget.dart';
import 'package:moru/utils/CustomColors.dart';

class ResubmitPhotosDialog {
  ResubmitPhotosDialog({
    required BuildContext context,
    required Uint8List bytes,
    required Function() onTab,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        var width = MediaQuery.of(context).size.width;

        return Dialog(
          backgroundColor: Color(0x0000ffff),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //SizedBox(height: 64),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Routes.pop(context);
                      },
                      child: SvgPicture.asset(
                        'assets/icons/cross.svg',
                        width: 38,
                        height: 38,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Container(
                  height: 450,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(bytes),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox(height: 38),
                ButtonWidget(
                  name: "Submit",
                  height: 50,
                  width: width * 0.87,
                  fontSize: 15,
                  backgroundColor: CustomColors.primarycolor,
                  textColor: Colors.white,
                  prefixIconPath: "assets/icons/reload.png",
                  onTap: () {
                    //Routes.pop(context);
                    onTab();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
