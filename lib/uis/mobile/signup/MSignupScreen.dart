import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/Routes.dart';
import 'package:moru/custom_widgets/ButtonWidget.dart';
import 'package:moru/custom_widgets/MyCheckBox.dart';
import 'package:moru/custom_widgets/MyInputField.dart';
import 'package:moru/custom_widgets/MyWrapButton.dart';
import 'package:moru/utils/CustomColors.dart';

class MSignupScreen extends StatefulWidget {
  const MSignupScreen({Key? key}) : super(key: key);

  @override
  State<MSignupScreen> createState() => _MSignupScreenState();
}

class _MSignupScreenState extends State<MSignupScreen> {
  bool? Value = false;
  bool? dValue = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.87;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Container(
                    height: 100,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/logo.svg',
                        width: 200,
                      ),
                    ),
                  ),
                  Container(
                    width: width,
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.syne(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  MyInputField(
                    heading: "Full Name",
                    width: width,
                  ),
                  SizedBox(
                    height: 15,
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
                  MyInputField(
                    heading: "Confirm Password",
                    width: width,
                  ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // Container(
                  //   width: width,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //         child: Text(
                  //           "Gender",
                  //           style: GoogleFonts.syne(
                  //             fontSize: 16,
                  //             color: CustomColors.inputfillColor,
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 8,
                  //       ),
                  //       Row(
                  //         children: [
                  //           MyWrapButton(
                  //             boxcolor: CustomColors.primarycolor,
                  //             btntxt: "Male",
                  //             fontcolor: Colors.white,
                  //             height: 40,
                  //           ),
                  //           SizedBox(
                  //             width: 18,
                  //           ),
                  //           MyWrapButton(
                  //             boxcolor:
                  //                 CustomColors.inputfillColor.withOpacity(0.07),
                  //             btntxt: "Female",
                  //             fontcolor: CustomColors.primarycolor,
                  //             height: 40,
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // MyCheckBox(
                  //   text: 'Accept terms and conditions',
                  //   width: width,
                  //   value: Value,
                  //   activeColor: CustomColors.primarycolor,
                  //   onChanged: (val) {
                  //     setState(() {
                  //       Value = val!;
                  //     });
                  //   },
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // MyCheckBox(
                  //   text: 'Privacy Policy',
                  //   width: width,
                  //   value: dValue,
                  //   activeColor: CustomColors.primarycolor,
                  //   onChanged: (val) {
                  //     setState(() {
                  //       dValue = val!;
                  //     });
                  //   },
                  // ),
                  SizedBox(
                    height: 40,
                  ),
                  ButtonWidget(
                    name: "Sign Up",
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
            ),
          ),
        ),
      ),
    );
  }
}
