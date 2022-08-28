import 'package:flutter/material.dart';

class MMainScreen extends StatefulWidget {
  const MMainScreen({Key? key}) : super(key: key);

  @override
  State<MMainScreen> createState() => _MMainScreenState();
}

class _MMainScreenState extends State<MMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Home screen"),
      ),
    );
  }
}
