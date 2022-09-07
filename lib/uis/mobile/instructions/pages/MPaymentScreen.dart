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
  TextEditingController promocodeController = TextEditingController();

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
    var jsonResponse = null;
    if (model.discountPercentage! < 100) {
      Map<String, dynamic> data = {
        "data": {
          "card": {
            "number": cardNoController.text.trim(),
            "exp_year": int.parse(yearController.text.trim()),
            "exp_month": int.parse(monthController.text.trim()),
            "cvc": cvvController.text.trim(),
          },
          "amount": model.getNewTotalCostPaid(),
          "description": "${user.fullname} - ${user.email} - ${model.plan}",
        },
      };

      jsonResponse = await repository.paymentApi.payWithProduct(data, context);
      if (jsonResponse.containsKey("error")) {
        EasyLoading.dismiss();
        Commons.toastMessage(context, "Please enter valid information");
        return;
      } else {
        model.stripeResponse = jsonResponse;
      }
    }

    model.createdDate = Timestamp.now().toDate();
    //appViewModel.updateCreateCheckupModel(model);

    //save
    List<Future> allFutures = [];
    // model.photos?.forEach((photo) {
    //
    // });
    for (var i = 0; i < model.photos!.length; i++) {
      allFutures.add(uploadFile(model.photos![i].bytes!, user.uid));
    }
    var allImages = await Future.wait(allFutures);
    print(allImages);

    for (var i = 0; i < allImages.length; i++) {
      model.photos![i].url = allImages[i];
      model.photos![i].title = "";
      model.photos![i].description = "";
    }

    Commons.consoleLog("model----------> ${model.toJson()}");

    await repository.cases.post(data: model.toJson());
    model = CaseModel();
    appViewModel.updateCreateCheckupModel(model);

    EasyLoading.dismiss();
    Routes.pushNamedAndRemoveUntil(context, Routes.APPOINMENT_DONE_PAGE);
  }

  Future<String> uploadFile(Uint8List byte, String? uid) async {
    try {
      final _firebaseStorage = FirebaseStorage.instance;
      //Uint8List imageData = await XFile(file.path).readAsBytes();
      // print(
      //     'cases/${uid}/${DateTime.now().millisecond}-${FileManger.getFileName(file.path)}.jpeg');
      print('cases/${uid}/${DateTime.now().microsecondsSinceEpoch}-moru.jpeg');
      var snapshot = await _firebaseStorage
          .ref()
          .child(
              'cases/${uid}/${DateTime.now().microsecondsSinceEpoch}-moru.jpeg')
          .putData(
            byte,
            SettableMetadata(
              contentType: 'image/jpeg',
            ),
          )
          .whenComplete(() => null);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e);
      return '';
    }
  }

  Future getPromocode() async {
    if (promocodeController.text.isEmpty) {
      Commons.toastMessage(context, "Please enter valid promocode");
    } else {
      EasyLoading.show(status: 'Paying...');
      var userViewModel = Provider.of<UserViewModel>(context, listen: false);
      var user = userViewModel.getModel();
      var appViewModel = Provider.of<AppViewModel>(context, listen: false);
      var model = appViewModel.getCreateCheckupModel();

      Map<String, dynamic> data = {
        "data": {
          "code": promocodeController.text.trim(),
          "productId": model.productId,
        },
      };

      var jsonResponse = await repository.paymentApi.getPromocode(data);
      if (jsonResponse.containsKey("error")) {
        EasyLoading.dismiss();
        Commons.toastMessage(context, "Please enter valid promocode");
      } else {
        var result = jsonResponse["result"];
        var success = result["success"];

        if (success) {
          var data = result["data"];
          var percentage_off = data["percentage_off"];
          model.coupon = promocodeController.text.trim();
          model.discountPercentage = percentage_off;
          appViewModel.updateCreateCheckupModel(model);
        } else {
          Commons.toastMessage(context, "Please enter valid promocode");
        }
        EasyLoading.dismiss();
      }
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
              Consumer<AppViewModel>(
                builder: (ctx, data, Widget? child) {
                  var model = data.getCreateCheckupModel();
                  double amount = model.totalCostPaid!;
                  double discount = model.discountPercentage!;
                  if (discount > 0) {
                    return Container(
                      //width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: CustomColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 16),
                          Image.asset(
                            'assets/icons/label.png',
                            width: 24,
                            height: 24,
                            color: CustomColors.green,
                          ),
                          SizedBox(width: 24),
                          Expanded(
                            child: Text(
                              "Freenze (${discount}% off)",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: CustomColors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  var appViewModel = Provider.of<AppViewModel>(
                                    context,
                                    listen: false,
                                  );
                                  var model =
                                      appViewModel.getCreateCheckupModel();
                                  model.discountPercentage = 0;
                                  appViewModel.updateCreateCheckupModel(model);
                                  promocodeController.text = "";
                                },
                                child: Text(
                                  'Remove',
                                  style: GoogleFonts.syne(
                                      fontSize: 17,
                                      color: CustomColors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                        ],
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              controller: promocodeController,
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
                              onTap: () {
                                getPromocode();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
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
        Consumer<AppViewModel>(
          builder: (ctx, data, Widget? child) {
            var model = data.getCreateCheckupModel();
            double amount = model.totalCostPaid!;
            double discount = model.discountPercentage!;
            if (discount == 100) {
              return Container();
            }
            return Container(
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
                          heading: 'Year',
                        ),
                      ),
                      SizedBox(width: 32),
                      Expanded(
                        child: MyInputField(
                          width: width,
                          controller: monthController,
                          keyboardType: TextInputType.number,
                          heading: 'Month',
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
            );
          },
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
        var model = data.getCreateCheckupModel();
        double amount = model.totalCostPaid!;
        double discount = model.discountPercentage!;

        amount = amount / 100;
        print("amount---> ${amount}");
        if (discount > 0) {
          var minus = (amount * discount) / 100;
          String inString = minus.toStringAsFixed(2); // '2.35'
          double inDouble = double.parse(inString); // 2.35
          minus = inDouble;
          if (discount == 100) minus = amount;

          print("minus---> ${minus}");
          amount = amount - minus;
          print("amount---> ${amount}");
        }

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
