import 'dart:ui';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/Routes.dart';
import 'package:moru/custom_widgets/ButtonWidget.dart';
import 'package:moru/custom_widgets/FooterWidget.dart';
import 'package:moru/custom_widgets/back_button/BackButtonWidget.dart';
import 'package:moru/uis/mobile/MMainScreen.dart';
import 'package:moru/uis/mobile/checkups/dialog/ResubmitPhotosDialog.dart';
import 'package:moru/uis/mobile/checkups/widgets/CheckupActionWidget.dart';
import 'package:moru/uis/mobile/checkups/widgets/CheckupStyleWidget.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:moru/utils/MoruIcons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MCheckupReadyScreen extends StatelessWidget {
  const MCheckupReadyScreen({Key? key}) : super(key: key);

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
          bottomSheet: FooterWidget(
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
                onTap: () {},
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );

    // return MMainScreen(
    //   selectedIndex: 1,
    //   child: CheckUp2Body(),
    //   bottomSheet: FooterWidget(
    //     children: [
    //       const SizedBox(height: 12),
    //       ButtonWidget(
    //         name: "Chat with a doctor",
    //         height: 50,
    //         width: width * 0.87,
    //         fontSize: 15,
    //         backgroundColor: CustomColors.primarycolor,
    //         textColor: Colors.white,
    //         prefixIconPath: "assets/icons/message.png",
    //         onTap: () {},
    //       ),
    //       const SizedBox(height: 24),
    //     ],
    //   ),
    // );
  }
}

class CheckUp2Body extends StatelessWidget {
  const CheckUp2Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<PhotoModel> photosLists = [
      PhotoModel('assets/images/card1.png', false),
      PhotoModel('assets/images/card2.png', true),
      PhotoModel('assets/images/card2.png', false),
      PhotoModel('assets/images/card1.png', true),
    ];

    Widget photoHorizontalList(List<PhotoModel> photos) {
      double size = 88;
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
                      image: AssetImage(photos[index].url),
                    ),
                  ),
                ),
                !photos[index].isVerified
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
            "None",
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
            "Dr Mariam Alzaabi",
            style: GoogleFonts.syne(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: CustomColors.inputfillColor,
            ),
          ),
          SizedBox(height: 2),
          Text(
            "Licenced in Dubai, UAE",
            style: GoogleFonts.syne(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: CustomColors.inputfillColor,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
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
                      index: 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: [
                            PhotoView.customChild(
                              child: Image.network(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7WLVv1HbS-YtqKc2q7RfubcfHsSucy_lPXw&usqp=CAU",
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
                      itemCount: 3,
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
                      "Moderate Overcrowding",
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
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
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
            alignment: Alignment.center,
            children: [
              Container(
                width: width,
                height: 4.0,
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
                    color:CustomColors.primarycolor,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 24),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
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
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
            style: GoogleFonts.syne(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: CustomColors.inputfillColor,
            ),
          ),
          SizedBox(height: 16),
          ButtonWidget(
            name: "Find nearby dentist",
            height: 50,
            width: width,
            fontSize: 19,
            backgroundColor: CustomColors.primarycolor,
            textColor: Colors.white,
            onTap: () {},
          ),
        ],
      );
    }

    Widget treatmentCostWidget() {
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
            SizedBox(height: 20),
            ButtonWidget(
              name: "Buy",
              height: 40,
              width: width,
              fontSize: 15,
              backgroundColor: CustomColors.primarycolor,
              textColor: Colors.white,
              onTap: () {},
            ),
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

    return ResponsiveBuilder(
      builder: (context, SizingInformation) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            CheckupStyleWidget(
              date: "14th_of_May_2022",
              title: "Emergency",
              title2: "report_ready",
              dotColor: CustomColors.green,
              icon: Moru.smile,
              showReport: false,
            ),
            const SizedBox(height: 8),
            CheckupActionWidget(
              title: "Reviewed by Dr. Mariam",
              title2: "King's College Hospital London",
              boxcolor: CustomColors.orangeshade,
              icon: Moru.person_add,
            ),
            const SizedBox(height: 24),
            LocaleText(
              "photos",
              style: GoogleFonts.syne(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            photoHorizontalList(photosLists),
            const SizedBox(height: 12),
            //resubmitPhotos(),
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
        );
      },
    );
  }
}

class PhotoModel {
  final String url;
  final bool isVerified;

  PhotoModel(this.url, this.isVerified);
}
