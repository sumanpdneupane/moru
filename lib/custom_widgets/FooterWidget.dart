import 'package:flutter/material.dart';

//You can copy paste run full code below
// You can use bottomSheet attribute of Scaffold
//
// return Scaffold(
//       ...
//       bottomSheet: Container(
//         width: MediaQuery.of(context).size.width,
//         child: RaisedButton(
//           child: Text('PROCEED'),
//           onPressed: () {},
//         ),
//       ),
//     );

class FooterWidget extends StatelessWidget {
  final List<Widget> children;

  FooterWidget({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}