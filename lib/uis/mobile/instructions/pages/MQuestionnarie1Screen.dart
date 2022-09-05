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

class MQuestionnarie1Screen extends StatefulWidget {
  const MQuestionnarie1Screen({Key? key}) : super(key: key);

  @override
  State<MQuestionnarie1Screen> createState() => _MQuestionnarie1ScreenState();
}

class _MQuestionnarie1ScreenState extends State<MQuestionnarie1Screen> {
  String question = 'Are you in pain ?';
  List<String> possibleAnswers = ['Yes, I’m in pain', 'No pain'];
  int? groupValue = 0;

  saveToStore() {
    if (groupValue == 0) {
      Routes.pushNamed(context, Routes.PAYMENT_PAGE);
    } else {
      var appViewModel = Provider.of<AppViewModel>(context, listen: false);
      var model = appViewModel.getCreateCheckupModel();
      model.questionaires!.add(
        QuestionairesModel(
          question: question,
          answer: possibleAnswers[groupValue!],
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
          question,
          style: GoogleFonts.syne(
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 50),
        ListView.builder(
          itemCount: possibleAnswers.length,
          itemBuilder: (c, i) {
            return Column(
              children: [
                radioButton(i, possibleAnswers[i]),
                SizedBox(height: 16),
              ],
            );
          },
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
