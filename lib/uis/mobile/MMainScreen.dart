import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/Routes.dart';
import 'package:moru/services/Repository.dart';
import 'package:moru/uis/mobile/contact/MContactScreen.dart';
import 'package:moru/uis/mobile/home/MHomeScreen.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/Commons.dart';
import 'checkups/MCheckupScreen.dart';

class MMainScreen extends StatefulWidget {
  int selectedIndex;
  Widget child;
  Widget? bottomSheet;
  Repository repository = Repository();

  List<Widget> screens = [
    MHomeScreen(),
    MCheckupScreen(),
    MContactScreen(),
  ];

  MMainScreen({
    Key? key,
    required this.selectedIndex,
    required this.child,
    this.bottomSheet,
  }) : super(key: key);

  @override
  State<MMainScreen> createState() => _MMainScreenState();
}

class _MMainScreenState extends State<MMainScreen> {
  @override
  void initState() {
    widget.selectedIndex = 0;
    super.initState();
  }

  void onindexchange(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  Color? bottomNavigationColor(int selectedIndex, int index) {
    return selectedIndex == index
        ? CustomColors.primarycolor
        : Colors.grey[500];
  }

  _launchURL() async {
    const url = 'https://wa.me/message/SFUXOSYWAUBDC1';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Commons.toastMessage(context, "Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, SizingInformation) {
        return Scaffold(
          body: widget.screens[widget.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            unselectedFontSize: 0,
            type: BottomNavigationBarType.fixed,
            currentIndex: widget.selectedIndex,
            onTap: (value) {
              if (value == 2) {
                _launchURL();
                return;
              }
              print("BottomNavigationBar::value--------> ${value}");
              onindexchange(value);
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/home.svg',
                  color: bottomNavigationColor(widget.selectedIndex, 0),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/tooth.svg',
                  width: 20,
                  color: bottomNavigationColor(widget.selectedIndex, 1),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/call.svg',
                  color: bottomNavigationColor(widget.selectedIndex, 2),
                ),
                label: '',
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await widget.repository.saveUserIdToLocal(uid: "");
              await widget.repository.authentication.signOut();
              Routes.popAndPushNamed(context, Routes.SPLASH_PAGE);
            },
            backgroundColor: CustomColors.primarycolor,
            child: Icon(
              Icons.output_outlined,
              color: CustomColors.white,
            ),
          ),
        );

        // return Scaffold(
        //   body: SafeArea(
        //     child: SingleChildScrollView(
        //       physics: AlwaysScrollableScrollPhysics(),
        //       child: Row(
        //         mainAxisSize: MainAxisSize.max,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Container(
        //             margin: EdgeInsets.only(
        //               top: 20,
        //               // left: 20,
        //               // right: 20,
        //             ),
        //             alignment: Alignment.topCenter,
        //             width: MediaQuery.of(context).size.width * 0.87,
        //             child: widget.screens[widget.selectedIndex],
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        //   bottomSheet: widget.bottomSheet,
        //   bottomNavigationBar: BottomNavigationBar(
        //     unselectedFontSize: 0,
        //     type: BottomNavigationBarType.fixed,
        //     currentIndex: widget.selectedIndex,
        //     onTap: (value) {
        //       print("BottomNavigationBar::value--------> ${value}");
        //       onindexchange(value);
        //     },
        //     items: [
        //       BottomNavigationBarItem(
        //         icon: SvgPicture.asset(
        //           'assets/icons/home.svg',
        //           color: bottomNavigationColor(widget.selectedIndex, 0),
        //         ),
        //         label: '',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: SvgPicture.asset(
        //           'assets/icons/tooth.svg',
        //           width: 20,
        //           color: bottomNavigationColor(widget.selectedIndex, 1),
        //         ),
        //         label: '',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: SvgPicture.asset(
        //           'assets/icons/call.svg',
        //           color: bottomNavigationColor(widget.selectedIndex, 2),
        //         ),
        //         label: '',
        //       ),
        //     ],
        //   ),
        //   // floatingActionButton: FloatingActionButton(
        //   //   backgroundColor: CustomColors.primarycolor,
        //   //   onPressed: () {
        //   //     showDialog(
        //   //       context: context,
        //   //       builder: (context) {
        //   //         return AlertDialog(
        //   //           title: Text('Language Change'),
        //   //           actions: [
        //   //             RaisedButton(
        //   //               onPressed: (() {
        //   //                 Locales.change(context, 'en');
        //   //                 Navigator.pop(context);
        //   //               }),
        //   //               color: CustomColors.primarycolor,
        //   //               child: Text(
        //   //                 "English",
        //   //                 style: TextStyle(
        //   //                   color: Colors.white,
        //   //                 ),
        //   //               ),
        //   //             ),
        //   //             SizedBox(
        //   //               width: 20,
        //   //             ),
        //   //             RaisedButton(
        //   //               onPressed: (() {
        //   //                 Locales.change(context, 'ar');
        //   //                 Navigator.pop(context);
        //   //               }),
        //   //               color: CustomColors.primarycolor,
        //   //               child: Text(
        //   //                 "Arabic",
        //   //                 style: TextStyle(
        //   //                   color: Colors.white,
        //   //                 ),
        //   //               ),
        //   //             ),
        //   //             SizedBox(
        //   //               width: 20,
        //   //             ),
        //   //           ],
        //   //         );
        //   //       },
        //   //     );
        //   //   },
        //   //   child: Icon(
        //   //     Icons.language_outlined,
        //   //     color: Colors.white,
        //   //     size: 32,
        //   //   ),
        //   // ),
        // );
      },
    );
  }

  Widget listtile(
    String svgicon,
    String title,
    Function ontap,
    int index,
    String routeName,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      onTap: () {
        ontap();
        Navigator.pushNamed(context, routeName);
      },
      horizontalTitleGap: 0,
      leading: SvgPicture.asset(
        svgicon,
        width: 15,
        color: widget.selectedIndex == index
            ? CustomColors.primarycolor
            : Colors.black,
      ),
      title: LocaleText(
        title,
        style: GoogleFonts.syne(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: widget.selectedIndex == index
              ? CustomColors.primarycolor
              : Colors.black,
        ),
      ),
    );
  }

  Widget tablisttile(
    String svgicon,
    Function ontap,
    int index,
    String routeName,
  ) {
    return GestureDetector(
      onTap: () {
        ontap();
        Navigator.pushNamed(context, routeName);
      },
      child: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 16,
          bottom: 16,
        ),
        child: SvgPicture.asset(
          svgicon,
          width: 15,
          color: widget.selectedIndex == index
              ? CustomColors.primarycolor
              : Colors.black,
        ),
      ),
    );
  }
}
