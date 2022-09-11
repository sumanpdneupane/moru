import 'package:flutter/material.dart';
import 'package:moru/custom_widgets/base_uis/BaseUIWidget.dart';
import 'package:moru/utils/Commons.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class MContactScreen extends StatefulWidget {
  const MContactScreen({Key? key}) : super(key: key);

  @override
  State<MContactScreen> createState() => _MContactScreenState();
}

class _MContactScreenState extends State<MContactScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseUIWidget(
      child: ContactBody(),
    );
  }
}

class ContactBody extends StatelessWidget {
  ContactBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return ResponsiveBuilder(
      builder: (context, SizingInformation) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
          ],
        );
      },
    );
  }
}
