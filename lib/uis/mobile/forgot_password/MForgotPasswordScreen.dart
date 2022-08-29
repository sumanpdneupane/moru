import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/Routes.dart';
import 'package:moru/custom_widgets/ButtonWidget.dart';
import 'package:moru/custom_widgets/FooterWidget.dart';
import 'package:moru/custom_widgets/MyInputField.dart';
import 'package:moru/utils/CustomColors.dart';

class MForgotPasswordScreen extends StatefulWidget {
  const MForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<MForgotPasswordScreen> createState() => _MForgotPasswordScreenState();
}

class _MForgotPasswordScreenState extends State<MForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.87;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 40),
              SizedBox(
                height: 100,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/logo.svg',
                    width: 200,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(),
                child: Text(
                  "Reset Password",
                  style: GoogleFonts.syne(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              MyInputField(
                heading: "Email",
                width: width,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: FooterWidget(
        children: [
          const SizedBox(
            height: 20,
          ),
          ButtonWidget(
            name: "Reset",
            height: 50,
            width: width,
            fontSize: 19,
            backgroundColor: CustomColors.primarycolor,
            textColor: Colors.white,
            onTap: () {
              Routes.popAndPushNamed(context, Routes.LOGIN_PAGE);
            },
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
