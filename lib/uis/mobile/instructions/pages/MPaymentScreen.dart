import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/Routes.dart';
import 'package:moru/custom_widgets/ButtonWidget.dart';
import 'package:moru/custom_widgets/FooterWidget.dart';
import 'package:moru/custom_widgets/InputTextField.dart';
import 'package:moru/custom_widgets/MyButton.dart';
import 'package:moru/custom_widgets/MyInputField.dart';
import 'package:moru/custom_widgets/back_button/BackButtonWidget.dart';
import 'package:moru/custom_widgets/base_uis/BaseUIWidget.dart';
import 'package:moru/uis/mobile/instructions/MInstructionScreen.dart';
import 'package:moru/utils/CustomColors.dart';

class MPaymentScreen extends StatefulWidget {
  const MPaymentScreen({Key? key}) : super(key: key);

  @override
  State<MPaymentScreen> createState() => _MPaymentScreenState();
}

class _MPaymentScreenState extends State<MPaymentScreen> {
  int selected = 0;

  void onchange(int index) {
    setState(() {
      selected = index;
    });
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
              Routes.pushNamed(context, Routes.APPOINMENT_DONE_PAGE);
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
                  Text(
                    '24',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.primarycolor,
                    ),
                  ),
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
              SizedBox(
                //width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: InputTextField(
                        heading: "",
                        hintText: "",
                        width: width,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: MyButton(
                        btntxt: 'apply',
                        boxcolor: CustomColors.primarycolor,
                        fontcolor: Colors.white,
                        width: width,
                      ),
                    ),
                  ],
                ),
              ),
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
                heading: 'Card Number',
              ),
              const SizedBox(height: 20),
              MyInputField(
                width: width,
                heading: 'Card Holder',
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: MyInputField(
                      width: width,
                      heading: 'Expiration Date',
                    ),
                  ),
                  SizedBox(width: 32),
                  Expanded(
                    child: MyInputField(
                      width: width,
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
