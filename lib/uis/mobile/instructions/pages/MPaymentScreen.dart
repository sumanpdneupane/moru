import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moru/Routes.dart';
import 'package:moru/custom_widgets/ButtonWidget.dart';
import 'package:moru/custom_widgets/FooterWidget.dart';
import 'package:moru/custom_widgets/InputTextField.dart';
import 'package:moru/custom_widgets/MyButton.dart';
import 'package:moru/custom_widgets/MyInputField.dart';
import 'package:moru/custom_widgets/back_button/BackButtonWidget.dart';
import 'package:moru/custom_widgets/base_uis/BaseUIWidget.dart';
import 'package:moru/libraries/FileManger.dart';
import 'package:moru/model/AppViewModel.dart';
import 'package:moru/model/CaseModel.dart';
import 'package:moru/model/UserModel.dart';
import 'package:moru/services/Repository.dart';
import 'package:moru/uis/mobile/instructions/MInstructionScreen.dart';
import 'package:moru/utils/Commons.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MPaymentScreen extends StatefulWidget {
  const MPaymentScreen({Key? key}) : super(key: key);

  @override
  State<MPaymentScreen> createState() => _MPaymentScreenState();
}

class _MPaymentScreenState extends State<MPaymentScreen> {
  Repository repository = Repository();
  int selected = 0;
  TextEditingController cardNoController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  void onchange(int index) {
    setState(() {
      selected = index;
    });
  }

  @override
  void initState() {
    var appViewModel = Provider.of<AppViewModel>(context, listen: false);
    var model = appViewModel.getCreateCheckupModel();
    model.questionaires?.forEach((element) {
      Commons.consoleLog("${element.question}----------> ${element.answer}");
    });

    getPaymentAmount();
    super.initState();
  }

  Future getPaymentAmount() async {
    EasyLoading.show(status: 'Fetching price...');
    var appViewModel = Provider.of<AppViewModel>(context, listen: false);
    var model = appViewModel.getCreateCheckupModel();
    var paymentableAmount =
        await repository.paymentApi.getProduct(model.priceId!);
    print("paymentableAmount---> ${paymentableAmount}");
    model.totalCostOfPlan = paymentableAmount;
    model.totalCostPaid = paymentableAmount;
    appViewModel.updateCreateCheckupModel(model);
    EasyLoading.dismiss();
  }

  Future payWithStripe() async {
    EasyLoading.show(status: 'Paying...');
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);
    var user = userViewModel.getModel();
    var appViewModel = Provider.of<AppViewModel>(context, listen: false);
    var model = appViewModel.getCreateCheckupModel();

    Map<String, dynamic> data = {
      "data": {
        "card": {
          "number": cardNoController.text.trim(),
          "exp_year": int.parse(yearController.text.trim()),
          "exp_month": int.parse(monthController.text.trim()),
          "cvc": cvvController.text.trim(),
        },
        "amount": model.totalCostPaid,
        "description": "${user.fullname} - ${user.email} - ${model.plan}",
      },
    };

    var jsonResponse =
        await repository.paymentApi.payWithProduct(data, context);

    if (jsonResponse.containsKey("error")) {
      EasyLoading.dismiss();
      Commons.toastMessage(context, "Please enter valid informatin");
    } else {
      model.stripeResponse = jsonResponse;
      model.createdDate = Timestamp.now().toDate();
      appViewModel.updateCreateCheckupModel(model);

      //save
      Commons.consoleLog("model----------> ${model.toJson()}");
      List<Future> allFutures = [];
      model.photos?.forEach((photo) {
        allFutures.add(uploadFile(photo.file!, user.uid));
      });
      var allImages = await Future.wait(allFutures);
      print(allImages);

      for (var i = 0; i < allImages.length; i++) {
        model.photos![i].url = allImages[i];
      }
      // await repository.cases.post(data: model.toJson());
      // model = CaseModel();
      // appViewModel.updateCreateCheckupModel(model);

      EasyLoading.dismiss();
      // Routes.pushNamedAndRemoveUntil(context, Routes.APPOINMENT_DONE_PAGE);
    }
  }

  Future<String> uploadFile(File file, String? uid) async {
    try {
      final _firebaseStorage = FirebaseStorage.instance;
      Uint8List imageData = await XFile(file.path).readAsBytes();
      print(
          'cases/${uid}/${DateTime.now().millisecond}-${FileManger.getFileName(file.path)}.jpeg');
      var snapshot = await _firebaseStorage
          .ref()
          .child(
              'cases/${uid}/${DateTime.now().millisecond}-${FileManger.getFileName(file.path)}')
          .putData(imageData)
          .whenComplete(() => null);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e);
      return '';
    }
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
          localeText: "payment",
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
            name: "Pay",
            height: 50,
            width: width * 0.87,
            fontSize: 15,
            backgroundColor: CustomColors.primarycolor,
            textColor: Colors.white,
            onTap: () {
              payWithStripe();
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget innerBody(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Column(
      // spacing: 200,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // color: Colors.orange,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  PaymentAmountWidget(),
                  Text(
                    'AED',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              LocaleText(
                'Promocode',
                style: GoogleFonts.syne(
                  fontSize: 16,
                  color: CustomColors.inputfillColor,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: InputTextField(
                      heading: "",
                      hintText: "",
                      controller: TextEditingController(),
                      width: width,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: ButtonWidget(
                      name: "Apply",
                      height: 50,
                      width: width,
                      fontSize: 15,
                      backgroundColor: CustomColors.primarycolor,
                      textColor: Colors.white,
                      onTap: () {},
                    ),
                    // child: MyButton(
                    //   btntxt: 'apply',
                    //   boxcolor: CustomColors.primarycolor,
                    //   fontcolor: Colors.white,
                    //   width: width,
                    // ),
                  ),
                ],
              ),
              // SizedBox(
              //   //width: 300,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Expanded(
              //         flex: 3,
              //         child: InputTextField(
              //           heading: "",
              //           hintText: "",
              //           width: width,
              //         ),
              //       ),
              //       SizedBox(width: 16),
              //       Expanded(
              //         flex: 1,
              //         child: ButtonWidget(
              //           name: "Apply",
              //           height: 50,
              //           width: width,
              //           fontSize: 15,
              //           backgroundColor: CustomColors.primarycolor,
              //           textColor: Colors.white,
              //           onTap: () {
              //           },
              //         ),
              //         // child: MyButton(
              //         //   btntxt: 'apply',
              //         //   boxcolor: CustomColors.primarycolor,
              //         //   fontcolor: Colors.white,
              //         //   width: width,
              //         // ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: 20),
            ],
          ),
        ),
        Container(
          // color: Colors.red,
          //width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: (() => onchange(0)),
                    child: Container(
                      height: 78,
                      width: 108,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selected == 0
                              ? CustomColors.primarycolor
                              : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        color: CustomColors.inputfillColor.withOpacity(0.3),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/visa_card.png',
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: (() => onchange(1)),
                    child: Container(
                      height: 78,
                      width: 108,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selected == 1
                              ? CustomColors.primarycolor
                              : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        color: CustomColors.inputfillColor.withOpacity(0.3),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/Mastercard.png',
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              MyInputField(
                width: width,
                controller: cardNoController,
                heading: 'Card Number',
              ),
              const SizedBox(height: 20),
              // MyInputField(
              //   width: width,
              //   controller: TextEditingController(),
              //   heading: 'Card Holder',
              // ),
              // const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: MyInputField(
                      width: width,
                      controller: yearController,
                      keyboardType: TextInputType.number,
                      heading: 'Expiration Year',
                    ),
                  ),
                  SizedBox(width: 32),
                  Expanded(
                    child: MyInputField(
                      width: width,
                      controller: monthController,
                      keyboardType: TextInputType.number,
                      heading: 'Expiration Month',
                    ),
                  ),
                  SizedBox(width: 32),
                  Expanded(
                    child: MyInputField(
                      width: width,
                      controller: cvvController,
                      heading: 'CVV',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}

//TODO: to show data
class PaymentAmountWidget extends StatelessWidget {
  const PaymentAmountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (ctx, data, Widget? child) {
        var amount = data.getCreateCheckupModel().totalCostOfPlan;
        amount = amount! / 100;

        return Text(
          "${amount}",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w600,
            color: CustomColors.primarycolor,
          ),
        );
      },
    );
  }
}
