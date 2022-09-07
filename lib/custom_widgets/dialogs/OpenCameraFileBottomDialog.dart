import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/custom_widgets/ButtonWidget.dart';
import 'package:moru/libraries/FileManger.dart';
import 'package:moru/utils/Commons.dart';
import 'package:moru/utils/Constants.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:universal_io/io.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// Created by Suman Prasad Neupane on 3/10/2022.
class OpenCameraFileBottomDialog {
  OpenCameraFileBottomDialog({
    BuildContext? context,
    FileType? fileType,
    List<String>? allowedExtensions,
    bool? allowExtensions,
    Function(Uint8List bytes)? callback,
  }) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context!,
      //isDismissible: false,
      builder: (context) => _OpenDialog(
        callback: callback,
        allowExtensions: allowExtensions,
      ),
    ).whenComplete(() {
      //dissmisDialog();
    });
  }
}

class _OpenDialog extends StatefulWidget {
  final Function(Uint8List bytes)? callback;
  final FileType? fileType;
  final List<String>? allowedExtensions;
  bool? allowExtensions;

  _OpenDialog({
    Key? key,
    this.callback,
    this.fileType,
    this.allowedExtensions,
    this.allowExtensions,
  }) : super(key: key);

  @override
  _OpenDialogState createState() => _OpenDialogState();
}

class _OpenDialogState extends State<_OpenDialog> {
  Widget space1() {
    return SizedBox(
      height: MediaQuery.of(context).size.width * .03,
    );
  }

  Widget space2() {
    return SizedBox(
      height: MediaQuery.of(context).size.width * .05,
    );
  }

  Widget spaceV1() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .03,
    );
  }

  Widget button({
    String? text,
    Color? textColor,
    Color? backgroundColor,
    Function? onTab,
  }) {
    return InkWell(
      onTap: () {
        onTab!();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 16, right: 16),
        padding: EdgeInsets.only(top: 12, bottom: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: new Text(
          "$text",
          textAlign: TextAlign.center,
          style: GoogleFonts.syne(
            fontSize: 20,
            color: textColor,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget title(String text) {
    return new Text(
      "$text",
      style: GoogleFonts.syne(
        fontSize: 17,
        color: CustomColors.black,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget addYourFile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: title(
            Constants.CAMER_OR_GALLERY,
          ),
        ),
        spaceV1(),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            //padding: EdgeInsets.all(8),
            // decoration: BoxDecoration(
            //   color: AppConstants.colors.whiteColor,
            //   borderRadius: BorderRadius.all(Radius.circular(0)),
            // ),
            child: Icon(
              Icons.clear,
              color: CustomColors.red,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: CustomColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          space1(),
          space2(),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: addYourFile(),
          ),
          space2(),
          !kIsWeb ? space2() : Container(),
          !kIsWeb
              ? button(
                  text: Constants.OPEN_CAMERA,
                  textColor: CustomColors.white,
                  backgroundColor: CustomColors.green,
                  onTab: () async {
                    Navigator.pop(context);
                    if (kIsWeb) {
                      //Routes.pushNamed(context, Routes.WEB_CAMERA_PAGE);
                      Commons.toastMessage(context, "Comming soon for web");
                    } else {
                      Uint8List? byte = await FileManger.openCamera();
                      if (byte == null) {
                        Commons.toastMessage(context, FileManger.NO_SELECTED);
                      } else {
                        widget.callback!(byte);
                      }
                    }
                  },
                )
              : Container(),
          space1(),
          button(
            text: !kIsWeb ? Constants.OPEN_GALLERY : Constants.CHOOSE_PHOTO,
            textColor: !kIsWeb ? CustomColors.black : CustomColors.white,
            backgroundColor:
                !kIsWeb ? CustomColors.greyLight : CustomColors.primarycolor,
            onTab: () async {
              Navigator.pop(context);
              Uint8List? byte;
              // if (!kIsWeb) {
              //   byte = await FileManger.openFileSystem(
              //     fileType: widget.fileType,
              //     allowedExtensions: widget.allowedExtensions,
              //     allowExtensions: widget.allowExtensions ?? false,
              //   );
              // }
              // else {
              //   byte = await FileManger.openCamera();
              // }
              byte = await FileManger.openFileSystem(
                fileType: widget.fileType,
                allowedExtensions: widget.allowedExtensions,
                allowExtensions: widget.allowExtensions ?? false,
              );

              if (byte == "") {
                Commons.toastMessage(context, FileManger.NO_SELECTED);
              } else {
                widget.callback!(byte!);
              }
            },
          ),
          space1(),
        ],
      ),
    );
  }
}

//https://pub.dev/packages/camera
