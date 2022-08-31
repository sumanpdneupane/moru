import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BaseUIWidget extends StatelessWidget {
  Widget? header;
  Widget child;
  Widget? bottomSheet;
  bool? resizeToAvoidBottomInset;

  BaseUIWidget({
    Key? key,
    this.header,
    required this.child,
    this.bottomSheet,
    this.resizeToAvoidBottomInset = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, SizingInformation) {
        return Scaffold(
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 24),
                header == null ? Container() : header!,
                Container(
                  height: 8,
                  color: Colors.white,
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
                          child: child,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: bottomSheet,
        );
      },
    );
  }
}
