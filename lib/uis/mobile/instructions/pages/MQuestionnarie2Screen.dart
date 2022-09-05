import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/Routes.dart';
import 'package:moru/custom_widgets/ButtonWidget.dart';
import 'package:moru/custom_widgets/FooterWidget.dart';
import 'package:moru/custom_widgets/InputTextField.dart';
import 'package:moru/custom_widgets/back_button/BackButtonWidget.dart';
import 'package:moru/custom_widgets/base_uis/BaseUIWidget.dart';
import 'package:moru/model/AppViewModel.dart';
import 'package:moru/model/CaseModel.dart';
import 'package:moru/uis/mobile/instructions/MInstructionScreen.dart';
import 'package:moru/utils/Commons.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:provider/provider.dart';

class MQuestionnarie2Screen extends StatefulWidget {
  const MQuestionnarie2Screen({Key? key}) : super(key: key);

  @override
  State<MQuestionnarie2Screen> createState() => _MQuestionnarie2ScreenState();
}

class _MQuestionnarie2ScreenState extends State<MQuestionnarie2Screen> {
  TextEditingController fullDescriptionController = TextEditingController();
  String question = "Tell us why you would like to get a dental consultation ?";

  saveToStore() {
    if (fullDescriptionController.text.isEmpty) {
      Commons.toastMessage(context, "Tell us what is happening");
    } else {
      var appViewModel = Provider.of<AppViewModel>(context, listen: false);
      var model = appViewModel.getCreateCheckupModel();
      model.questionaires!.add(
        QuestionairesModel(
          question: question,
          answer: fullDescriptionController.text.trim(),
        ),
      );
      appViewModel.updateCreateCheckupModel(model);

      Routes.pushNamed(context, Routes.QUESTIONNARE_2_PAGE);
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return BaseUIWidget(
      header: Container(
        width: width * 0.87,
        child: BackButtonWidget(
          onTap: () {
            Routes.pop(context);
          },
          localeText: "full_assessment2",
        ),
      ),
      child: InstructionMainBody(
        botombtn: Container(),
        innerbody: innerBody(context),
      ),
      bottomSheet: FooterWidget(
        children: [
          const SizedBox(height: 12),
          ButtonWidget(
            name: "Next",
            height: 50,
            width: width * 0.87,
            fontSize: 15,
            backgroundColor: CustomColors.primarycolor,
            textColor: Colors.white,
            onTap: () {
              saveToStore();
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget innerBody(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'most_important',
          style: GoogleFonts.syne(
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 50),
        InputTextField(
          heading: "",
          hintText: "I have sever teeth pain....",
          controller: fullDescriptionController,
          width: width,
          maxLines: 20,
        ),
      ],
    );
  }
}
