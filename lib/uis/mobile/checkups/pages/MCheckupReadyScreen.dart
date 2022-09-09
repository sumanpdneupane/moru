import 'dart:ui';
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moru/Routes.dart';
import 'package:moru/custom_widgets/ButtonWidget.dart';
import 'package:moru/custom_widgets/FooterWidget.dart';
import 'package:moru/custom_widgets/back_button/BackButtonWidget.dart';
import 'package:moru/model/AppViewModel.dart';
import 'package:moru/model/CaseModel.dart';
import 'package:moru/model/UserModel.dart';
import 'package:moru/uis/mobile/MMainScreen.dart';
import 'package:moru/uis/mobile/checkups/dialog/ResubmitPhotosDialog.dart';
import 'package:moru/uis/mobile/checkups/widgets/CheckupActionWidget.dart';
import 'package:moru/uis/mobile/checkups/widgets/CheckupStyleWidget.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:moru/utils/MoruIcons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MCheckupReadyScreen extends StatefulWidget {
  const MCheckupReadyScreen({Key? key}) : super(key: key);

  @override
  State<MCheckupReadyScreen> createState() => _MCheckupReadyScreenState();
}

class _MCheckupReadyScreenState extends State<MCheckupReadyScreen> {
  CaseModel? caseModel;

  @override
  void initState() {
    var viewModel = Provider.of<AppViewModel>(context, listen: false);
    caseModel = viewModel.getSingleCaseCheckupModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return ResponsiveBuilder(
      builder: (context, SizingInformation) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 24),
                Container(
                  width: MediaQuery.of(context).size.width * 0.87,
                  child: BackButtonWidget(
                    onTap: () {
                      Routes.pop(context);
                    },
                    localeText: "back_to_checkups",
                  ),
                ),
                Container(
                  height: 8,
                  color: Colors.transparent,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          alignment: Alignment.topCenter,
                          width: MediaQuery.of(context).size.width * 0.87,
                          child: CheckUp2Body(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: chatButton(width, context),
        );
      },
    );
  }

  Widget? chatButton(width, context) {
    if (caseModel == null || caseModel!.createdDate == null) {
      return null;
    }

    final createdDate = caseModel!.createdDate!;
    final date2 = DateTime.now();
    var difference = date2.difference(createdDate).inDays;

    print("DateTimeDIfference---------> ${difference}");

    if (difference > 3) {
      return null;
    }

    return FooterWidget(
      children: [
        const SizedBox(height: 12),
        ButtonWidget(
          name: "Chat with a doctor",
          height: 50,
          width: width * 0.87,
          fontSize: 15,
          backgroundColor: CustomColors.primarycolor,
          textColor: Colors.white,
          prefixIconPath: "assets/icons/message.png",
          onTap: () {
            Routes.pushNamed(context, Routes.CHAT_PAGE);
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

// class MCheckupReadyScreen extends StatelessWidget {
//   const MCheckupReadyScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//
//     return ResponsiveBuilder(
//       builder: (context, SizingInformation) {
//         return Scaffold(
//           body: SafeArea(
//             child: Column(
//               children: [
//                 SizedBox(height: 24),
//                 Container(
//                   width: MediaQuery.of(context).size.width * 0.87,
//                   child: BackButtonWidget(
//                     onTap: () {
//                       Routes.pop(context);
//                     },
//                     localeText: "back_to_checkups",
//                   ),
//                 ),
//                 Container(
//                   height: 8,
//                   color: Colors.transparent,
//                 ),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     physics: AlwaysScrollableScrollPhysics(),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(top: 4),
//                           alignment: Alignment.topCenter,
//                           width: MediaQuery.of(context).size.width * 0.87,
//                           child: CheckUp2Body(),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           bottomSheet: chatButton(width, context, caseM),
//         );
//       },
//     );
//   }
//
//   Widget chatButton(width, context) {
//     final birthday = DateTime(1967, 10, 12);
//     final date2 = DateTime.now();
//     final difference = date2.difference(birthday).inDays;
//
//     if (difference > 3) {
//       return Container();
//     }
//
//     return FooterWidget(
//       children: [
//         const SizedBox(height: 12),
//         ButtonWidget(
//           name: "Chat with a doctor",
//           height: 50,
//           width: width * 0.87,
//           fontSize: 15,
//           backgroundColor: CustomColors.primarycolor,
//           textColor: Colors.white,
//           prefixIconPath: "assets/icons/message.png",
//           onTap: () {
//             Routes.pushNamed(context, Routes.CHAT_PAGE);
//           },
//         ),
//         const SizedBox(height: 24),
//       ],
//     );
//   }
// }

class CheckUp2Body extends StatefulWidget {
  const CheckUp2Body({Key? key}) : super(key: key);

  @override
  State<CheckUp2Body> createState() => _CheckUp2BodyState();
}

class _CheckUp2BodyState extends State<CheckUp2Body> {
  CaseModel? caseModel;
  UserModel? currentUser;
  UserModel? doctor;

  int whatISawIndex = 0;

  @override
  void initState() {
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);
    currentUser = userViewModel.getModel();

    var viewModel = Provider.of<AppViewModel>(context, listen: false);
    caseModel = viewModel.getSingleCaseCheckupModel();

    print("caseModel--initState---------> ${caseModel!.id}");
    //getCaseDetailInfo();
    getDoctorInfo();
    super.initState();
  }

  Future getCaseDetailInfo() async {
    var doc = await FirebaseFirestore.instance
        .collection('cases')
        .doc(caseModel!.id)
        .get();

    Map data = doc.data() as Map;
    caseModel = CaseModel.fromJson(doc.id, data);
    setState(() {});
  }

  Future getDoctorInfo() async {
    var doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(caseModel!.assignedTo)
        .get();

    Map data = doc.data() as Map;
    doctor = UserModel.fromJson(doc.id, data);
    print("doctor---- > ${doctor!.toJson()}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Widget photoHorizontalList() {
      double size = 88;
      List<PhotoModel> photos = [];

      if (caseModel != null && caseModel!.photos != null) {
        photos = caseModel!.photos!;
      }

      return Container(
        height: size + 10,
        child: ListView.builder(
          //padding: const EdgeInsets.all(16),
          itemCount: photos.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                Container(
                  height: size,
                  width: size,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(
                        photos[index].url != null ? photos[index].url! : "",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                photos[index].status! == PhotoModel.REJECTED
                    ? GestureDetector(
                        onTap: () {
                          ResubmitPhotosDialog(context: context);
                        },
                        child: Container(
                          height: size,
                          width: size,
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: CustomColors.darkred.withOpacity(0.45),
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/icons/alert.png",
                              height: 32,
                              width: 32,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            );
          },
        ),
      );
    }

    Widget resubmitPhotos() {
      return InkWell(
        onTap: (() {}),
        child: Container(
          height: 52,
          width: 100,
          decoration: BoxDecoration(
            color: Color(0xff00AFC1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              "Resubmit",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }

    Widget reportWidget() {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: CustomColors.primarycolor.withOpacity(0.3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 64),
                Image.asset(
                  'assets/icons/report.png',
                  width: 24,
                  height: 24,
                  color: CustomColors.primarycolor,
                ),
                SizedBox(width: 64),
                LocaleText(
                  "report",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.syne(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.primarycolor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: CustomColors.primarycolor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      //bottomRight: Radius.circular(16),
                    ),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Center(
                    child: LocaleText(
                      "diagonsis",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.syne(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 2),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: CustomColors.primarycolor,
                  ),
                  padding: EdgeInsets.all(12),
                  child: Center(
                    child: LocaleText(
                      "next_step",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.syne(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.primarycolorLight,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 2),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: CustomColors.primarycolor,
                    borderRadius: BorderRadius.only(
                      //bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Center(
                    child: LocaleText(
                      "cost",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.syne(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.primarycolorLight,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    Widget replyFromDoctor() {
      if (doctor == null) {
        return Container();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LocaleText(
            "you_asked",
            style: GoogleFonts.syne(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "${caseModel!.replyFromPatient}",
            style: GoogleFonts.syne(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: CustomColors.inputfillColor,
            ),
          ),
          SizedBox(height: 8),
          LocaleText(
            "reply_from",
            style: GoogleFonts.syne(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "${doctor!.fullname != null ? doctor!.fullname! : ""}",
            style: GoogleFonts.syne(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: CustomColors.inputfillColor,
            ),
          ),
          SizedBox(height: 2),
          Text(
            "Licenced in ${doctor!.licensedFrom != null ? doctor!.licensedFrom : ""}",
            style: GoogleFonts.syne(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: CustomColors.inputfillColor,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "${caseModel!.replyFromDoctor}",
            style: GoogleFonts.syne(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: CustomColors.inputfillColor,
            ),
          ),
        ],
      );
    }

    Widget whatIsawWidget() {
      if (caseModel == null ||
          caseModel!.photos == null ||
          caseModel!.photos!.length < 1) {
        return Container();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LocaleText(
            "what_i_saw",
            style: GoogleFonts.syne(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: CustomColors.primarycolor.withOpacity(0.3),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: Container(
                    height: 150,
                    child: Swiper(
                      index: whatISawIndex,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: [
                            PhotoView.customChild(
                              child: Image.network(
                                caseModel!.photos![index].url!,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        );
                      },
                      onIndexChanged: (int index) {
                        whatISawIndex = index;
                        setState(() {});
                      },
                      itemCount: caseModel!.photos!.length,
                      curve: Curves.easeInOut,
                      indicatorLayout: PageIndicatorLayout.SCALE,
                      pagination: SwiperPagination(
                        builder: SwiperPagination.dots,
                      ),
                      physics: AlwaysScrollableScrollPhysics(),
                      control: SwiperControl(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  child: Center(
                    child: Text(
                      "${caseModel!.photos![whatISawIndex].title!}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.syne(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.primarycolor2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            "${caseModel!.photos![whatISawIndex].description!}",
            style: GoogleFonts.syne(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: CustomColors.inputfillColor,
            ),
          ),
        ],
      );
    }

    Widget whatCanYouDo() {
      double scaleWidth = width - 64;
      double severityScale = 8;
      double scaleVale = 0.0;
      if (severityScale == 0) {
        scaleVale = 0.0;
      } else if (severityScale == 10) {
        scaleVale = scaleWidth;
      } else {
        //TODO need to calculate
        severityScale = 10 - severityScale;
        scaleVale = scaleWidth / severityScale;
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LocaleText(
            "what_you_can_do",
            style: GoogleFonts.syne(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "Severity Scale",
            style: GoogleFonts.syne(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 24),
          Stack(
            //alignment: Alignment,
            children: [
              Container(
                width: scaleWidth,
                height: 4.0,
                margin: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue,
                      Colors.green,
                      Colors.yellow,
                      Colors.orange,
                      Colors.red,
                    ],
                  ),
                ),
              ),
              Container(
                width: scaleVale + 20,
                alignment: Alignment.centerRight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: CustomColors.primarycolor,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 24),
          Text(
            "${caseModel!.whatYouCanDo}",
            style: GoogleFonts.syne(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: CustomColors.inputfillColor,
            ),
          ),
        ],
      );
    }

    Widget nextStep() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LocaleText(
            "next_steps",
            style: GoogleFonts.syne(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "${caseModel!.nextSteps}",
            style: GoogleFonts.syne(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: CustomColors.inputfillColor,
            ),
          ),
          // SizedBox(height: 16),
          // ButtonWidget(
          //   name: "Find nearby dentist",
          //   height: 50,
          //   width: width,
          //   fontSize: 19,
          //   backgroundColor: CustomColors.primarycolor,
          //   textColor: Colors.white,
          //   onTap: () {},
          // ),
        ],
      );
    }

    Widget treatmentCostWidget() {
      if (caseModel == null ||
          caseModel!.recommendedTreatments == null ||
          caseModel!.recommendedTreatments!.length < 1) {
        return Container();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LocaleText(
            "treatment_cost",
            style: GoogleFonts.syne(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          ListView.builder(
            //padding: const EdgeInsets.all(16),
            itemCount: 3,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(top: 4, bottom: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Text(
                          "Treatment ${index + 1}",
                          style: GoogleFonts.syne(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: CustomColors.inputfillColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          "${(index + 1) * 459} AED",
                          style: GoogleFonts.syne(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: CustomColors.inputfillColor,
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      );
    }

    Widget recommendedProductsItemWidget(int index) {
      return Container(
        margin: EdgeInsets.only(left: 8, right: 8),
        child: Column(
          children: [
            Container(
              height: 150,
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage("assets/images/neurology.png"),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Oral-B Vitality 100 Cross Action Electric Toothbrush",
              textAlign: TextAlign.start,
              style: GoogleFonts.syne(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: CustomColors.inputfillColor,
              ),
            ),
            // SizedBox(height: 20),
            // ButtonWidget(
            //   name: "Buy",
            //   height: 40,
            //   width: width,
            //   fontSize: 15,
            //   backgroundColor: CustomColors.primarycolor,
            //   textColor: Colors.white,
            //   onTap: () {},
            // ),
          ],
        ),
      );
    }

    Widget recommendedProductsWidget() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LocaleText(
            "recommended_products",
            style: GoogleFonts.syne(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          GridView.builder(
            itemCount: 2,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 280,
              crossAxisSpacing: 8,
              mainAxisSpacing: 0,
            ),
            itemBuilder: (BuildContext context, int i) {
              return recommendedProductsItemWidget(i);
            },
          ),
        ],
      );
    }

    String convertDateTime() {
      String date = caseModel!.createdDate!.day.toString() +
          "th of" +
          DateFormat(" MMM y").format(caseModel!.createdDate!);
      print("caseids------------> ${caseModel!.id}");
      return date;
    }

    return ResponsiveBuilder(
      builder: (context, SizingInformation) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            caseModel != null
                ? CheckupStyleWidget(
                    date: convertDateTime(),
                    title: "Emergency",
                    title2: "${caseModel!.status!.toUpperCase()}",
                    dotColor: CustomColors.green,
                    icon: Moru.smile,
                    showReport: false,
                    caseModel: caseModel!,
                  )
                : Container(),
            const SizedBox(height: 8),
            doctor != null
                ? CheckupDoctorWidget(
                    title: "Reviewed by ${doctor!.fullname}",
                    title2: "${doctor!.collegeName} ${doctor!.collegeAddress}",
                    boxcolor: CustomColors.orangeshade,
                    icon: Moru.person_add,
                    photo: doctor!.photo!,
                  )
                : Container(),
            const SizedBox(height: 24),
            LocaleText(
              "photos",
              style: GoogleFonts.syne(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            photoHorizontalList(),
            const SizedBox(height: 12),
            //resubmitPhotos(),
            Container(),

            caseModel!.status == "reportReady"
                ? Column(
                    children: [
                      reportWidget(),
                      const SizedBox(height: 24),
                      replyFromDoctor(),
                      const SizedBox(height: 32),
                      whatIsawWidget(),
                      SizedBox(height: 32),
                      whatCanYouDo(),
                      SizedBox(height: 32),
                      nextStep(),
                      SizedBox(height: 32),
                      treatmentCostWidget(),
                      SizedBox(height: 32),
                      recommendedProductsWidget(),
                      SizedBox(height: 120),
                    ],
                  )
                : Column(),
          ],
        );
      },
    );
  }
}
