import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moru/custom_widgets/ButtonWidget.dart';
import 'package:moru/custom_widgets/base_uis/BaseUIWidget.dart';
import 'package:moru/model/AppViewModel.dart';
import 'package:moru/model/CaseModel.dart';
import 'package:moru/model/UserModel.dart';
import 'package:moru/services/Repository.dart';
import 'package:moru/uis/mobile/MMainScreen.dart';
import 'package:moru/uis/mobile/checkups/widgets/CheckupStyleWidget.dart';
import 'package:moru/uis/mobile/home/widgets/CheckupWidget.dart';
import 'package:moru/uis/mobile/home/widgets/HowItWorkWidget.dart';
import 'package:moru/uis/mobile/home/widgets/TrackWidgets.dart';
import 'package:moru/uis/mobile/home/widgets/UpcomingCheckupWidget.dart';
import 'package:moru/uis/mobile/home/widgets/WelcomeWidget.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:moru/utils/MoruIcons.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MHomeScreen extends StatefulWidget {
  const MHomeScreen({Key? key}) : super(key: key);

  @override
  State<MHomeScreen> createState() => _MHomeScreenState();
}

class _MHomeScreenState extends State<MHomeScreen> {
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

    appViewModel.getAllCheckupModel().forEach((element) {
      print("updateAllCheckupModel------------> ${element.replyFromPatient}");
    });
  }

  @override
  void initState() {
    loadAllCases();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BaseUIWidget(
      child: HomePgeBody(),
      header: Container(
        width: width * 0.87,
        child: WelcomeWidget(),
      ),
    );
  }
}

class HomePgeBody extends StatelessWidget {
  const HomePgeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ResponsiveBuilder(builder: (context, SizingInformation) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32),
          HowItWorkWidget(),
          Visibility(
            visible: false,
            child: SizedBox(height: 24),
          ),
          Visibility(
            visible: false,
            child: UpcomingCheckupWidget(),
          ),
          SizedBox(
            height: 32,
          ),
          LocaleText(
            'checkup1',
            style: GoogleFonts.syne(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          CheckupWidget(),
          SizedBox(
            height: 32,
          ),
          LocaleText(
            'track',
            style: GoogleFonts.syne(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          //future needed
          // TrackWidgets(),
          // SizedBox(
          //   height: 12,
          // ),
          // TrackWidgets(
          //   boxcolor: CustomColors.orangeshade,
          //   icon: Moru.teeth_add,
          //   lcltxt: 'emergency',
          //   lcltxt2: 'report_ready',
          //   lcltxt3: '14th_of_may_2022',
          //   circlecolor: CustomColors.darkred,
          // ),

          CheckupStyle(),

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
          SizedBox(
            height: 48,
          ),
        ],
      );
    });
  }
}

class CheckupStyle extends StatelessWidget {
  const CheckupStyle({Key? key}) : super(key: key);

  Widget loadData(List<CaseModel> model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListView.builder(
          //padding: const EdgeInsets.all(16),
          itemCount: model.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            String date = model[index].createdDate!.day.toString() + "th of" + DateFormat(" MMM y").format(model[index].createdDate!);

            return Container(
              margin: EdgeInsets.only(bottom: 8),
              child: CheckupStyleWidget(
                date: "${date}",
                title: "full_assessment",
                title2: "${model[index].status!.toUpperCase()}",
                dotColor: CustomColors.yellow,
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (ctx, data, Widget? child) {
      var model = data.getAllCheckupModel();
      return loadData(model);
    });
  }
}
