import 'package:flutter/material.dart';

class MContactUsScreen extends StatefulWidget {
  const MContactUsScreen({Key? key}) : super(key: key);

  @override
  State<MContactUsScreen> createState() => _MContactUsScreenState();
}

class _MContactUsScreenState extends State<MContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text("MContactUsScreen"),
          ),
        ),
      ),
    );
  }
}
