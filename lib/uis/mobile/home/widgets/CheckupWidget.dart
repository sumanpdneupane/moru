import 'package:flutter/material.dart';
import 'package:moru/Routes.dart';
import 'package:moru/custom_widgets/grids/MyGrid.dart';
import 'package:moru/utils/Commons.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:moru/utils/MoruIcons.dart';

class CheckupWidget extends StatelessWidget {
  const CheckupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Expanded(
          child: GridView.count(
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.3,
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              GestureDetector(
                onTap: (() {
                  Routes.pushNamed(context, Routes.INSTRUCTION_PAGE);
                }),
                child: MyGrid(
                  icon: Moru.teeth_cross,
                  text: 'single_issue',
                  color: CustomColors.primarycolor2,
                ),
              ),
              GestureDetector(
                onTap: (() {
                  //Routes.pushNamed(context, Routes.INSTRUCTION_PAGE);
                }),
                child: MyGrid(
                  icon: Moru.smile,
                  text: 'full_assessment',
                  color: CustomColors.primarycolor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Commons.toastMessage(context, "Comming Soon.");
                },
                child: MyGrid(
                  icon: Moru.teeth_calen,
                  text: 'video_consultation',
                  color: CustomColors.yellow,
                ),
              ),
              // Visibility(
              //   visible: false,
              //   child: MyGrid(
              //     icon: Moru.teeth_add,
              //     text: 'emergency',
              //     color: CustomColors.orangeshade,
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
