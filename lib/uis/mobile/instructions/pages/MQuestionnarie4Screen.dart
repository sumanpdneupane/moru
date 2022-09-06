import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/Routes.dart';
import 'package:moru/custom_widgets/ButtonWidget.dart';
import 'package:moru/custom_widgets/FooterWidget.dart';
import 'package:moru/custom_widgets/back_button/BackButtonWidget.dart';
import 'package:moru/custom_widgets/base_uis/BaseUIWidget.dart';
import 'package:moru/model/AppViewModel.dart';
import 'package:moru/model/CaseModel.dart';
import 'package:moru/uis/mobile/instructions/MInstructionScreen.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:provider/provider.dart';

class MQuestionnarie4Screen extends StatefulWidget {
  const MQuestionnarie4Screen({Key? key}) : super(key: key);

  @override
  State<MQuestionnarie4Screen> createState() => _MQuestionnarie4ScreenState();
}

class _MQuestionnarie4ScreenState extends State<MQuestionnarie4Screen> {
  String question = 'How would you describe your pain?';
  List<String> possibleAnswers = [
    'Burning',
    'Stabbing',
    'Tingling',
    'Aching',
  ];
  int? groupValue = 0;
  int currentIndex = 2;

  saveToStore() {
    var appViewModel = Provider.of<AppViewModel>(context, listen: false);
    var model = appViewModel.getCreateCheckupModel();
    if (model.questionaires!.length == currentIndex) {
      model.questionaires!.add(
        QuestionairesModel(
          question: question,
          answer: possibleAnswers[groupValue!],
        ),
      );
    } else {
      model.questionaires![currentIndex].question = question;
      model.questionaires![currentIndex].answer = possibleAnswers[groupValue!];
    }
    appViewModel.updateCreateCheckupModel(model);

    Routes.pushNamed(context, Routes.QUESTIONNARE_5_PAGE);
  }

  @override
  void initState() {
    var appViewModel = Provider.of<AppViewModel>(context, listen: false);
    var model = appViewModel.getCreateCheckupModel();
    if (currentIndex <= model.questionaires!.length - 1) {
      groupValue =
          possibleAnswers.indexOf(model.questionaires![currentIndex].answer!);
    }
    super.initState();
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

  List<Widget> answerWidgets() {
    List<Widget> items = [];
    for (int i = 0; i < possibleAnswers.length; i++) {
      var child = Container(
        margin: EdgeInsets.only(bottom: 16),
        child: radioButton(i, possibleAnswers[i]),
      );
      items.add(child);
    }
    return items;
  }

  Widget innerBody(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: GoogleFonts.syne(
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 50),
        Column(
          children: answerWidgets(),
        ),
      ],
    );
  }

  Container radioButton(int value, String text) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: CustomColors.primarycolor,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: FractionallySizedBox(
        child: Row(
          children: [
            Radio(
              activeColor: CustomColors.primarycolor,
              fillColor: MaterialStateColor.resolveWith(
                (states) => CustomColors.primarycolor,
              ),
              value: value,
              groupValue: groupValue,
              onChanged: ((int? value) {
                setState(() {
                  groupValue = value;
                });
              }),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: GoogleFonts.syne(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
