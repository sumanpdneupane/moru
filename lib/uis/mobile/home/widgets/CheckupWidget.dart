
import 'package:flutter/material.dart';
import 'package:moru/Routes.dart';
import 'package:moru/custom_widgets/grids/MyGrid.dart';
import 'package:moru/model/AppViewModel.dart';
import 'package:moru/model/CaseModel.dart';
import 'package:moru/utils/Commons.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:moru/utils/MoruIcons.dart';
import 'package:provider/provider.dart';

class CheckupWidget extends StatelessWidget {
  const CheckupWidget({Key? key}) : super(key: key);

  void routeToSingleIssue(BuildContext context) {
    var appViewModel = Provider.of<AppViewModel>(context, listen: false);
    var model = appViewModel.getCreateCheckupModel();

    //refresh case model from begining
    model = CaseModel();
    //add min and max photo can be uploaded
    model.lowerPhotoBoundSize = 1;
    model.upperPhotoBoundSize = 2;
    model.plan = CaseModel.SINGLE_ISSUE_PLAN;
    model.priceId = "price_1LZC7LDXe16sDQVN287FtFur";
    model.productId = "prod_MHle6zMmxr5Mik";

    appViewModel.updateCreateCheckupModel(model);

    //Navigate
    Routes.pushNamed(context, Routes.INSTRUCTION_PAGE);
  }

  void routeToFullAssessment(BuildContext context) {
    var appViewModel = Provider.of<AppViewModel>(context, listen: false);
    var model = appViewModel.getCreateCheckupModel();

    //refresh case model from begining
    model = CaseModel();
    //add min and max photo can be uploaded
    model.lowerPhotoBoundSize = 3;
    model.upperPhotoBoundSize = double.minPositive.toInt();
    model.plan = CaseModel.FULL_ASSESSMENT_PLAN;
    model.priceId = "price_1LZC7pDXe16sDQVND8b3cPGD";
    model.productId = "prod_MHlfxSndZMsJpX";

    appViewModel.updateCreateCheckupModel(model);

    //Navigate
    Routes.pushNamed(context, Routes.INSTRUCTION_PAGE);
  }

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
                  routeToSingleIssue(context);
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
