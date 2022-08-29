import 'package:flutter/material.dart';
import 'package:moru/Routes.dart';
import 'package:moru/custom_widgets/ButtonWidget.dart';
import 'package:moru/custom_widgets/FooterWidget.dart';
import 'package:moru/custom_widgets/MyInputField.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MLoginScreen extends StatefulWidget {
  const MLoginScreen({Key? key}) : super(key: key);

  @override
  State<MLoginScreen> createState() => _MLoginScreenState();
}

class _MLoginScreenState extends State<MLoginScreen> {
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
                  "Sign In",
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
              SizedBox(
                height: 15,
              ),
              MyInputField(
                heading: "Password",
                width: width,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: width,
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Forget Password",
                        style: GoogleFonts.syne(
                          fontSize: 16,
                          color: CustomColors.inputfillColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Routes.popAndPushNamed(context, Routes.FORGOT_PAGE);
                          },
                          child: Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              color: CustomColors.orangeshade,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
            name: "Sign In",
            height: 50,
            width: width,
            fontSize: 19,
            backgroundColor: CustomColors.primarycolor,
            textColor: Colors.white,
            onTap: () {
              Routes.popAndPushNamed(context, Routes.HOME_PAGE);
            },
          ),
          const SizedBox(
            height: 16,
          ),
          ButtonWidget(
            name: "Sign Up",
            height: 50,
            width: width,
            fontSize: 19,
            backgroundColor: CustomColors.primarycolor2,
            textColor: Colors.white,
            onTap: () {
              Routes.popAndPushNamed(context, Routes.SIGNUP_PAGE);
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
