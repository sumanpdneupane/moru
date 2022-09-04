import 'package:flutter/material.dart';

class Constants{
  static final navigatorKey = new GlobalKey<NavigatorState>();

  //Camera or Gallery
  static String get OPEN_CAMERA => "Open Camera";
  static String get OPEN_GALLERY => "Open Gallery";
  static String get CAMER_OR_GALLERY => "Open camera to take photos and open gallery to select image and file.";

}