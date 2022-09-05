import 'package:flutter/material.dart';
import 'package:moru/model/CaseModel.dart';

class AppViewModel with ChangeNotifier {
  CaseModel _createCheckupModel = CaseModel();

  void updateCreateCheckupModel(CaseModel model) {
    _createCheckupModel = model;
    notifyListeners();
  }

  CaseModel getCreateCheckupModel() {
    return _createCheckupModel;
  }
}