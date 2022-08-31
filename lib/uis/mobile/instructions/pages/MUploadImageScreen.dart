import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moru/Routes.dart';
import 'package:moru/custom_widgets/ButtonWidget.dart';
import 'package:moru/custom_widgets/FooterWidget.dart';
import 'package:moru/custom_widgets/MyButton.dart';
import 'package:moru/custom_widgets/back_button/BackButtonWidget.dart';
import 'package:moru/custom_widgets/base_uis/BaseUIWidget.dart';
import 'package:moru/libraries/FileManger.dart';
import 'package:moru/uis/mobile/instructions/MInstructionScreen.dart';
import 'package:moru/utils/Commons.dart';
import 'package:moru/utils/CustomColors.dart';

List<File> files = [];

class MUploadImageScreen extends StatefulWidget {
  const MUploadImageScreen({Key? key}) : super(key: key);

  @override
  State<MUploadImageScreen> createState() => _MUploadImageScreenState();
}

class _MUploadImageScreenState extends State<MUploadImageScreen> {


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;

    return BaseUIWidget(
      header: Container(
        width: width * 0.87,
        child: BackButtonWidget(
          onTap: () {
            Routes.pop(context);
          },
          localeText: "take_image",
        ),
      ),
      child: InstructionMainBody(
        botombtn: Container(),
        innerbody: innerBody(context),
      ),
      bottomSheet: FooterWidget(
        children: [
          const SizedBox(height: 12),
          ButtonWidget(
            name: "Take next photo",
            height: 50,
            width: width * 0.87,
            fontSize: 15,
            backgroundColor: CustomColors.primarycolor,
            textColor: Colors.white,
            onTap: () async {
              files = [];
              String path = await FileManger.openCamera();
              if (path == FileManger.NO_SELECTED) {
                Commons.toastMessage(context, path);
              } else {
                //widget.callback!(path);
                addImageFile(path);
              }
            },
          ),
          const SizedBox(height: 12),
          ButtonWidget(
            name: "Next",
            height: 50,
            width: width * 0.87,
            fontSize: 15,
            backgroundColor: CustomColors.primarycolor2,
            textColor: Colors.white,
            onTap: () {
              Routes.pushNamed(context, Routes.QUESTIONNARE_1_PAGE);
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Align innerBody(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;

    return Align(
      alignment: Alignment.center,
      child: Container(
        //height: 300,
          child: files.length > 0 ? imageView(files[0], 450) : Container(
            height: 450,
            //width: width * 0.7,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/card4.png'),
                fit: BoxFit.contain,
              ),
              //borderRadius: BorderRadius.circular(20),
            ),
          ),
      ),
    );
  }

  Widget imageView(File file, double height) {
    return Container(
      padding: EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.file(
          file,
          //fit: BoxFit.fill,
          fit: BoxFit.contain,
          width: height,
          height: height,
        ),
      ),
    );
  }

  void addImageFile(String path) {
    setState(() {
      files.add(File(path));
    });
  }

  void removeImageFileAt(int index) {
    setState(() {
      files.removeAt(index);
    });
  }
}



