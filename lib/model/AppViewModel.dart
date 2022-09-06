import 'package:flutter/material.dart';
import 'package:moru/model/CaseModel.dart';

class AppViewModel with ChangeNotifier {
  CaseModel _createCheckupModel = CaseModel();
  List<CaseModel> _getAllCheckupModels = [];

  void updateCreateCheckupModel(CaseModel model) {
    _createCheckupModel = model;
    notifyListeners();
  }

  CaseModel getCreateCheckupModel() {
    return _createCheckupModel;
  }

  void updateAllCheckupModel(List<CaseModel> models) {
    _getAllCheckupModels = models;
    notifyListeners();
  }

  List<CaseModel> getAllCheckupModel() {
    return _getAllCheckupModels;
  }
}