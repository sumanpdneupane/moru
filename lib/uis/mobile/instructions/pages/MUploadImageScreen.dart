import 'dart:io';
import 'dart:typed_data';
import 'package:moru/model/AppViewModel.dart';
import 'package:moru/model/CaseModel.dart';
import 'package:provider/provider.dart';
import 'package:universal_io/io.dart' as universal;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moru/Routes.dart';
import 'package:moru/custom_widgets/ButtonWidget.dart';
import 'package:moru/custom_widgets/FooterWidget.dart';
import 'package:moru/custom_widgets/MyButton.dart';
import 'package:moru/custom_widgets/back_button/BackButtonWidget.dart';
import 'package:moru/custom_widgets/base_uis/BaseUIWidget.dart';
import 'package:moru/custom_widgets/dialogs/OpenCameraFileBottomDialog.dart';
import 'package:moru/libraries/FileManger.dart';
import 'package:moru/uis/mobile/instructions/MInstructionScreen.dart';
import 'package:moru/utils/Commons.dart';
import 'package:moru/utils/CustomColors.dart';

List<File> imageFiles = [];

class MUploadImageScreen extends StatefulWidget {
  const MUploadImageScreen({Key? key}) : super(key: key);

  @override
  State<MUploadImageScreen> createState() => _MUploadImageScreenState();
}

class _MUploadImageScreenState extends State<MUploadImageScreen> {
  Future openCameraOrGallery(BuildContext context) async {
    OpenCameraFileBottomDialog(
      context: context,
      fileType: FileType.image,
      allowExtensions: false,
      callback: (Uint8List bytes) {
        if (bytes == null) {
          Commons.toastMessage(context, FileManger.NO_SELECTED);
        } else {
          addImageToModel(context, bytes);
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
            backgroundColor: CustomColors.white,
            textColor: CustomColors.primarycolor2,
            onTap: () async {
              openCameraOrGallery(context);
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
              if (checkIfCanProceedToNext(context)) {
                Routes.pushNamed(context, Routes.QUESTIONNARE_1_PAGE);
              }
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Align innerBody(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.center,
      child: Container(
        child: LoadImageGridViewWidget(
          removeFileAt: (int index) {
            removeImageFromModel(index);
          },
        ),
      ),
    );
  }

  bool checkIfCanProceedToNext(BuildContext context) {
    var appViewModel = Provider.of<AppViewModel>(context, listen: false);
    var model = appViewModel.getCreateCheckupModel();
    var photos = model.photos;

    if (photos != null && photos.length < 1) {
      Commons.toastMessage(context, "Please take photo");
      return false;
    } else if (photos!.length < model.lowerPhotoBoundSize) {
      Commons.toastMessage(
        context,
        "Please take greater than ${model.lowerPhotoBoundSize} photo",
      );
      return false;
    } else if (photos.length > model.upperPhotoBoundSize) {
      Commons.toastMessage(
        context,
        "You can upload only less than ${model.upperPhotoBoundSize} photo",
      );
      return false;
    }

    return true;
  }

  Future<void> addImageToModel(BuildContext context, Uint8List bytes) async {
    var appViewModel = Provider.of<AppViewModel>(context, listen: false);
    var model = appViewModel.getCreateCheckupModel();
    model.photos!.add(
      PhotoModel(
        description: "",
        url: "",
        title: "",
        status: PhotoModel.ACTIVE,
        bytes: bytes,
      ),
    );
    appViewModel.updateCreateCheckupModel(model);
  }

  Future<void> removeImageFromModel(int index) async {
    // setState(() {
    //   imageFiles.removeAt(index);
    // });
    var appViewModel = Provider.of<AppViewModel>(context, listen: false);
    var model = appViewModel.getCreateCheckupModel();
    model.photos!.removeAt(index);
    appViewModel.updateCreateCheckupModel(model);
  }
}

//TODO: to show data
class LoadImageGridViewWidget extends StatelessWidget {
  final Function(int index)? removeFileAt;

  LoadImageGridViewWidget({
    Key? key,
    this.removeFileAt,
  }) : super(key: key);

  double height = 450;
  double width = 450;

  Widget imageBackground(height) {
    return Container(
      padding: EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          color: CustomColors.white,
          height: height,
        ),
      ),
    );
  }

  Widget imageView(Uint8List bytes, height, context) {
    return Container(
      padding: EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: FileManger.loadImageFile(
          bytes: bytes,
          height: height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }

  Widget removeImageView(int index) {
    return Positioned(
      right: 0,
      top: 0,
      child: InkWell(
        onTap: () {
          removeFileAt!(index);
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: CustomColors.red,
          ),
          padding: EdgeInsets.all(4.0),
          child: Icon(
            Icons.clear,
            color: CustomColors.white,
            size: 16,
          ),
        ),
      ),
    );
  }

  Widget showInGrid(BuildContext context, List<PhotoModel> photoModels) {
    return Container(
      margin: EdgeInsets.only(bottom: 280),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: photoModels.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          crossAxisCount: 2,
          mainAxisExtent: 200,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            //fit: StackFit.expand,
            children: [
              imageBackground(height),
              imageView(photoModels[index].bytes!, height, context),
              removeImageView(index)
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (ctx, data, Widget? child) {
        var photoModels = data.getCreateCheckupModel().photos;
        return photoModels != null && photoModels.length > 0
            ? showInGrid(context, photoModels)
            : Container(
                height: height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/card4.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              );
      },
    );
  }
}
