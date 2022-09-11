import 'package:cloud_firestore/cloud_firestore.dart';
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
    String url =
        "https://firebasestorage.googleapis.com/v0/b/web-rtc-6f95e.appspot.com/o/cases%2FGdqpE6Q4boTUUK5P6Mf0VQipuoS2%2F1662570587254000-moru.jpeg?alt=media&token=d198a81f-de90-4482-9c7f-d3b70544a91d";

    return ResponsiveBuilder(builder: (context, SizingInformation) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32),
          // Image.network(
          //   height: 200,
          //   width: 300,
          //   url,
          // ),
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
            String date = model[index].createdDate!.day.toString() +
                "th of" +
                DateFormat(" MMM y").format(model[index].createdDate!);

            print("caseids------------> ${model[index].id}");

            return Container(
              margin: EdgeInsets.only(bottom: 8),
              child: CheckupStyleWidget(
                date: "${date}",
                title: "full_assessment",
                title2: "${model[index].status!.formateCaseStatusStr}",
                dotColor: model[index].status!.formateCaseStatusColor,
                icon: model[index].status!.formateCaseStatusIcon,
                boxcolor: model[index].status!.formateCaseStatusBackground,
                caseModel: model[index],
                showReport:
                    model[index].status!.formateCaseStatusStr == "REPORT READY",
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

      return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('cases')
              .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.length < 1) {
            return Container();
          }

          List<CaseModel> model =
          snapshot.data!.docs.map((doc) {
            Map data = doc.data() as Map;
            return new CaseModel.fromJson(doc.id, data);
          }).toList();

          model.sort((a, b) {
            return b.createdDate!.compareTo(a.createdDate!);
          });

          return loadData(model);
        }
      );
    });
  }
}
