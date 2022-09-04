import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/model/UserModel.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ResponsiveBuilder(builder: (context, SizingInformation) {
      return Consumer<UserViewModel>(
        builder: (BuildContext ctx, data, Widget? child) {
          return Row(
            children: [
              Text(
                "${context.localeString('welcome_user')} ${data.getModel().fullname}",
                style: GoogleFonts.syne(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(
                    'assets/logo.svg',
                    width: 96,
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
