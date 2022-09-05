import 'dart:io';

//import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/Routes.dart';
import 'package:moru/custom_widgets/ButtonWidget.dart';
import 'package:moru/custom_widgets/FooterWidget.dart';
import 'package:moru/custom_widgets/back_button/BackButtonWidget.dart';
import 'package:moru/custom_widgets/base_uis/BaseUIWidget.dart';
import 'package:moru/custom_widgets/dialogs/OpenCameraFileBottomDialog.dart';
import 'package:moru/libraries/FileManger.dart';
import 'package:moru/uis/mobile/instructions/pages/MUploadImageScreen.dart';
import 'package:moru/utils/Commons.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:moru/utils/MoruIcons.dart';

class MInstructionScreen extends StatelessWidget {
  const MInstructionScreen({Key? key}) : super(key: key);

  Future openCameraOrGallery(BuildContext context) async {
    files = [];
    OpenCameraFileBottomDialog(
      context: context,
      fileType: FileType.image,
      allowExtensions: false,
      callback: (String path) {
        if (path == FileManger.NO_SELECTED) {
          Commons.toastMessage(context, path);
        } else {
          files.add(File(path));
          Routes.pushNamed(context, Routes.UPLOAD_IMAGE_PAGE);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return BaseUIWidget(
      header: Container(
        width: width * 0.87,
        child: BackButtonWidget(
          onTap: () {
            Routes.pop(context);
          },
          localeText: "instruction",
        ),
      ),
      child: InstructionMainBody(
        botombtn: Container(),
      ),
      bottomSheet: FooterWidget(
        children: [
          const SizedBox(height: 12),
          ButtonWidget(
            name: "Start Checkup",
            height: 50,
            width: width * 0.87,
            fontSize: 15,
            backgroundColor: CustomColors.primarycolor,
            textColor: Colors.white,
            onTap: () async {
              await openCameraOrGallery(context);
              // files = [];
              // String path = await FileManger.openCamera();
              // if (path == FileManger.NO_SELECTED) {
              //   Commons.toastMessage(context, path);
              // } else {
              //   files.add(File(path));
              // }
              //
              // Routes.pushNamed(context, Routes.UPLOAD_IMAGE_PAGE);
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class InstructionMainBody extends StatelessWidget {
  Widget innerbody;
  Widget botombtn;
  String heading, topboxtxt;
  Color topboxcolor;
  IconData topboxicon;
  Color progresscolor;
  double currentvalue;

  InstructionMainBody({
    Key? key,
    this.heading = 'instruction',
    this.innerbody = const InnerBody(),
    required this.botombtn,
    this.topboxcolor = CustomColors.primarycolor,
    this.topboxicon = Moru.smile,
    this.topboxtxt = 'full_assessment',
    this.currentvalue = 20,
    this.progresscolor = CustomColors.primarycolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          child: Padding(
            //padding: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                innerbody,
                botombtn,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BottomButton extends StatelessWidget {
  Function ontap;
  String btntxt;
  double width;
  AlignmentGeometry alignment;

  BottomButton({
    Key? key,
    required this.ontap,
    this.btntxt = 'next',
    this.width = 100,
    this.alignment = Alignment.topRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: GestureDetector(
        onTap: (() {
          ontap();
        }),
        child: Container(
          height: 50,
          width: width,
          decoration: BoxDecoration(
            color: CustomColors.primarycolor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: CustomColors.primarycolor,
            ),
          ),
          child: Flexible(
            child: FractionallySizedBox(
              widthFactor: 0.7,
              child: Center(
                child: FittedBox(
                  child: LocaleText(
                    btntxt,
                    style: GoogleFonts.syne(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InnerBody extends StatelessWidget {
  const InnerBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      //width: 600,
      child: Wrap(
        runSpacing: 20,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          Container(
            height: 450,
            //width: ,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/selfie.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          SizedBox(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1. ',
                      style: GoogleFonts.syne(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Expanded(
                      child: LocaleText(
                        'take_pic_of_teeth',
                        style: GoogleFonts.syne(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2. ',
                      style: GoogleFonts.syne(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Expanded(
                      child: LocaleText(
                        'tell_the_dentist_why_you_want_a_consultation',
                        style: GoogleFonts.syne(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '3. ',
                      style: GoogleFonts.syne(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Expanded(
                      child: LocaleText(
                        'provide_payment_details_at_checkout',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.syne(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
