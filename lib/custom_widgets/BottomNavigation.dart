// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:moru/utils/CustomColors.dart';
//
// class BottomNavigation extends StatefulWidget {
//   List<TabItem> tabItems;
//   List<Widget> listWidgets;
//
//   BottomNavigation({
//     Key? key,
//     required this.tabItems,
//     required this.listWidgets,
//   }) : super(key: key);
//
//   @override
//   _BottomNavigationState createState() => _BottomNavigationState();
// }
//
// class _BottomNavigationState extends State<BottomNavigation> {
//   int selectedIndex = 0;
//
//   onTap(int index) {
//     //print('click index=$index');
//     setState(() {
//       selectedIndex = index;
//     });
//   }
//
//   convexAppBar() {
//     return StyleProvider(
//       style: Style(),
//       child: ConvexAppBar(
//         disableDefaultTabController: true,
//         backgroundColor: Colors.white,
//         activeColor: CustomColors.primarycolor,
//         color: CustomColors.primarycolor,
//         elevation: 8.0,
//         height: 60,
//         top: -26,
//         //style: TabStyle.fixedCircle,
//         //curveSize: 100,
//         items: widget.tabItems,
//         initialActiveIndex: 0,
//         onTap: (int i) => onTap(i),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //widget.tabItems = Constants.getMTabItems();
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       bottomNavigationBar: convexAppBar(),
//       body: widget.listWidgets[selectedIndex],
//     );
//   }
// }
//
// class Style extends StyleHook {
//   @override
//   double get activeIconSize => 32;
//
//   @override
//   double get activeIconMargin => 12;
//
//   @override
//   double get iconSize => 28;
//
//   @override
//   TextStyle textStyle(Color color) {
//     return TextStyle(
//       fontSize: 13,
//       color: Colors.grey[200],
//       fontWeight: FontWeight.w500,
//     );
//   }
// }
