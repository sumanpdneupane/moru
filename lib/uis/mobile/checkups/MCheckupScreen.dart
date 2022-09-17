import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/custom_widgets/InputTextField.dart';
import 'package:moru/custom_widgets/MyInputField.dart';
import 'package:moru/custom_widgets/base_uis/BaseUIWidget.dart';
import 'package:moru/model/AppViewModel.dart';
import 'package:moru/model/CaseModel.dart';
import 'package:moru/model/UserModel.dart';
import 'package:moru/services/Repository.dart';
import 'package:moru/uis/mobile/MMainScreen.dart';
import 'package:moru/uis/mobile/checkups/widgets/CheckupStyleWidget.dart';
import 'package:moru/uis/mobile/home/MHomeScreen.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:moru/utils/MoruIcons.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MCheckupScreen extends StatefulWidget {
  const MCheckupScreen({Key? key}) : super(key: key);

  @override
  State<MCheckupScreen> createState() => _MCheckupScreenState();
}

class _MCheckupScreenState extends State<MCheckupScreen> {
  Repository repository = Repository();

  Future loadAllCases() async {
    EasyLoading.show(status: 'Loading...');
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);
    var appViewModel = Provider.of<AppViewModel>(context, listen: false);
    var user = userViewModel.getModel();
    List<CaseModel>? cases =
        await repository.cases.getByUserId(userId: user.uid);
    appViewModel.updateAllCheckupModel(cases);
    EasyLoading.dismiss();

    // appViewModel.getAllCheckupModel().forEach((element) {
    //   print("updateAllCheckupModel------------> ${element.replyFromPatient}");
    // });
  }

  @override
  void initState() {
    loadAllCases();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseUIWidget(
      child: CheckupBody(),
    );
  }
}

class CheckupBody extends StatelessWidget {
  CheckupBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return ResponsiveBuilder(
      builder: (context, SizingInformation) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Container(
              alignment: Alignment.center,
              child: LocaleText(
                "checkup",
                style: GoogleFonts.syne(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 32),
            // InputTextField(
            //   heading: "Email",
            //   hintText: 'Search checkups',
            //   prefixicon: Image.asset(
            //     'assets/icons/search.png',
            //   ),
            //   width: width * 0.87,
            // ),
            // SizedBox(height: 16),
            // CheckupStyleWidget(
            //   date: "14th_of_May_2022",
            //   title: "full_assessment",
            //   title2: "in_progress",
            //   dotColor: CustomColors.yellow,
            // ),
            // SizedBox(height: 8),
            // CheckupStyleWidget(
            //   date: "10th_of_aprill_2022",
            //   title: "single_issue",
            //   title2: "need_update",
            //   boxcolor: CustomColors.orangeshade,
            //   icon: Moru.teeth_calen,
            //   dotColor: CustomColors.red,
            // ),
            // SizedBox(height: 8),
            // CheckupStyleWidget(
            //   date: "14th_of_May_2022",
            //   title: "Emergency",
            //   title2: "report_ready",
            //   dotColor: CustomColors.green,
            //   icon: Moru.teeth_cross,
            //   showReport: true,
            // ),
            // SizedBox(height: 8),
            // CheckupStyleWidget(
            //   date: "10th_of_aprill_2022",
            //   title: "emergency",
            //   title2: "report_ready",
            //   dotColor: CustomColors.green,
            //   icon: Moru.teeth_add,
            //   showReport: true,
            // ),
            CheckupStyle(),
          ],
        );
      },
    );
  }
}
