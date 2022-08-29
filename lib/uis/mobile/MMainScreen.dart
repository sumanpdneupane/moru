import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MMainScreen extends StatefulWidget {
  int selectedIndex;
  Widget child;

  MMainScreen({
    Key? key,
    required this.selectedIndex,
    required this.child,
  }) : super(key: key);

  @override
  State<MMainScreen> createState() => _MMainScreenState();
}

class _MMainScreenState extends State<MMainScreen> {
  void onindexchange(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, SizingInformation) {
        return Scaffold(
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 6,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 20,
                    ),
                    width: MediaQuery.of(context).size.width * 0.87,
                    child: SingleChildScrollView(
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //   backgroundColor: CustomColors.primarycolor,
          //   onPressed: () {
          //     showDialog(
          //       context: context,
          //       builder: (context) {
          //         return AlertDialog(
          //           title: Text('Language Change'),
          //           actions: [
          //             RaisedButton(
          //               onPressed: (() {
          //                 Locales.change(context, 'en');
          //                 Navigator.pop(context);
          //               }),
          //               color: CustomColors.primarycolor,
          //               child: Text(
          //                 "English",
          //                 style: TextStyle(
          //                   color: Colors.white,
          //                 ),
          //               ),
          //             ),
          //             SizedBox(
          //               width: 20,
          //             ),
          //             RaisedButton(
          //               onPressed: (() {
          //                 Locales.change(context, 'ar');
          //                 Navigator.pop(context);
          //               }),
          //               color: CustomColors.primarycolor,
          //               child: Text(
          //                 "Arabic",
          //                 style: TextStyle(
          //                   color: Colors.white,
          //                 ),
          //               ),
          //             ),
          //             SizedBox(
          //               width: 20,
          //             ),
          //           ],
          //         );
          //       },
          //     );
          //   },
          //   child: Icon(
          //     Icons.language_outlined,
          //     color: Colors.white,
          //     size: 32,
          //   ),
          // ),
          bottomNavigationBar: BottomNavigationBar(
                  unselectedFontSize: 0,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: widget.selectedIndex,
                  onTap: (value) {
                    setState(() {
                      widget.selectedIndex = value;
                    });
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
                    // BottomNavigationBarItem(
                    //   icon: SvgPicture.asset(
                    //     'assets/icons/bell.svg',
                    //     color: bottomNavigationColor(widget.selectedIndex, 2),
                    //   ),
                    //   label: '',
                    // ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/menu.svg',
                        color: bottomNavigationColor(widget.selectedIndex, 3),
                      ),
                      label: '',
                    ),
                  ],
                )

        );
      },
    );
  }

  Color? bottomNavigationColor(int selectedIndex, int index) {
    return selectedIndex == index
        ? CustomColors.primarycolor
        : Colors.grey[500];
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
