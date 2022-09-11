import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:moru/utils/Commons.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:moru/utils/MoruIcons.dart';

class CaseModel {
  String? id;
  String? caseNo;

  String? createdBy;
  String? assignedTo;
  String? whatYouCanDo;
  String? replyFromDoctor;
  String? replyFromPatient;
  var severityScale;

  DateTime? createdDate;
  DateTime? lastStatusUpdated;
  String? nextSteps;

  double? totalCostOfPlan;
  double? totalCostPaid;
  double? discountAmount;
  double? discountPercentage;
  String? priceId;
  String? productId;
  String? coupon;
  dynamic stripeResponse;

  String? plan; //singleTissue/fullAssessment
  static String SINGLE_ISSUE_PLAN = "singleTissue";
  static String FULL_ASSESSMENT_PLAN = "fullAssessment";

  String? status; //pending/reportReady/needUpdate

  //For photo
  int lowerPhotoBoundSize = 0;
  int upperPhotoBoundSize = 0;
  List<PhotoModel>? photos;

  List<QuestionairesModel>? questionaires;
  List<dynamic>? recommendedProducts = [];
  List<dynamic>? recommendedTreatments = [];

  CaseModel({
    this.id,
    this.caseNo = "",
    this.assignedTo,
    this.whatYouCanDo = "",
    this.replyFromDoctor = "",
    this.replyFromPatient = "",
    this.severityScale = 0,
    this.createdDate,
    this.createdBy,
    this.lastStatusUpdated,
    this.nextSteps = "",
    this.coupon = "",
    this.stripeResponse,
    this.totalCostOfPlan = 0,
    this.totalCostPaid = 0,
    this.discountAmount = 0,
    this.discountPercentage = 0,
    this.plan = "",
    this.status = "",
    this.lowerPhotoBoundSize = 1,
    this.upperPhotoBoundSize = 2,
    List<PhotoModel>? photos,
    List<QuestionairesModel>? questionaires,
    List<dynamic>? recommendedProducts,
    List<dynamic>? recommendedTreatments,
  }) {
    this.photos = photos == null ? [] : photos;
    this.questionaires = questionaires == null ? [] : questionaires;
    this.recommendedProducts =
        recommendedProducts == null ? [] : recommendedProducts;
    this.recommendedTreatments =
        recommendedTreatments == null ? [] : recommendedTreatments;
  }

  CaseModel.fromJson(String uid, Map<dynamic, dynamic> json) {
    this.id = uid;
    if (json != null && json.length > 0) {
      this.caseNo = json["caseNo"] ?? "";
      this.assignedTo = json["assignedTo"];
      this.whatYouCanDo = json["whatYouCanDo"];
      this.replyFromDoctor = json["replyFromDoctor"];
      this.replyFromPatient = json["replyFromPatient"];

      this.severityScale = json["severityScale"];
      this.createdBy = json["createdBy"];

      var createdDate = json['createdDate'] as Timestamp;
      this.createdDate = createdDate != null ? createdDate.toDate() : null;

      if (json['lastStatusUpdated'] != null) {
        var lastStatusUpdated = json['lastStatusUpdated'] as Timestamp;
        this.lastStatusUpdated =
            lastStatusUpdated != null ? lastStatusUpdated.toDate() : null;
      }

      this.nextSteps = json["nextSteps"];
      this.coupon = json["coupon"];
      this.stripeResponse = json["stripeResponse"];
      this.totalCostOfPlan = double.parse("${json["totalCostOfPlan"]}");
      this.totalCostPaid = double.parse("${json["totalCostPaid"]}");

      if (json.containsKey("discountAmount") &&
          json["discountAmount"] != null &&
          json["discountAmount"] != "") {
        print("discountAmount----> ${json["discountAmount"]}");
        this.discountAmount = double.parse("${json["discountAmount"]}");
      }
      this.plan = json["plan"];
      this.status = json["status"];

      if (json["photos"] != null) {
        this.photos = <PhotoModel>[];
        json["photos"].forEach((v) {
          this.photos?.add(new PhotoModel.fromJson(v));
        });
      }

      if (json["questionaires"] != null) {
        this.questionaires = <QuestionairesModel>[];
        json["questionaires"].forEach((v) {
          this.questionaires?.add(new QuestionairesModel.fromJson(v));
        });
      }
      //this.questionaires = json["questionaires"];
      this.recommendedProducts = json["recommendedProducts"];
      this.recommendedTreatments = json["recommendedTreatments"];
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map();

    data["caseNo"] = caseNo;
    data["createdBy"] = createdBy;
    data["assignedTo"] = assignedTo;
    data["createdDate"] = createdDate;
    data["replyFromPatient"] = replyFromPatient;

    if (stripeResponse != null) {
      data["stripeResponse"] = stripeResponse;
    }
    if (discountPercentage! > 0) {
      totalCostPaid =
          totalCostOfPlan! - (totalCostOfPlan! * discountPercentage!) / 100;
      discountAmount = totalCostOfPlan! - totalCostPaid!;
    }
    data["totalCostOfPlan"] = totalCostOfPlan;
    data["totalCostPaid"] = totalCostPaid;
    data["discountAmount"] = discountAmount;

    data["coupon"] = coupon;

    data["plan"] = plan;
    data["status"] = status;
    data["discountAmount"] = discountAmount;

    // questionaires?.forEach((element) {
    //   Commons.consoleLog("${element.question}----------> ${element.answer}");
    // });
    if (questionaires != null) {
      data["questionaires"] = questionaires!.map((element) {
        return element.toJson();
      }).toList();
    }

    if (photos != null) {
      data["photos"] = photos!.map((element) {
        return element.toJson();
      }).toList();
    }
    return data;
  }

  double? getNewTotalCostPaid() {
    if (discountPercentage! > 0) {
      var totalCostPaid =
          totalCostOfPlan! - (totalCostOfPlan! * discountPercentage!) / 100;
      return totalCostPaid;
    }
    return totalCostOfPlan;
  }
}

class PhotoModel {
  String? description;
  String? title;
  String? url;
  String? status; //active/rejected
  Uint8List? bytes;

  static String ACTIVE = "active";
  static String REJECTED = "rejected";

  PhotoModel({
    this.description = "",
    this.title = "",
    required this.url,
    this.status = "active",
    this.bytes = null,
  });

  PhotoModel copyWith({
    String? description,
    String? title,
    String? url,
    String? status, //active/rejected
    Uint8List? bytes,
  }) {
    return PhotoModel(
        description: this.description = description ?? this.description,
        title: this.title = title ?? this.title,
        url: this.url = url ?? this.url,
        status: this.status = status ?? this.status,
        bytes: this.bytes = bytes ?? this.bytes);
  }

  PhotoModel.fromJson(Map<dynamic, dynamic> json) {
    if (json != null && json.length > 0) {
      this.description = json["description"];
      this.title = json["title"];
      this.url = json["url"];
      this.status = json["status"];
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map();
    data["description"] = description;
    data["title"] = title;
    data["url"] = url;
    data["status"] = status;
    return data;
  }
}

class QuestionairesModel {
  String? question;
  String? answer;

  QuestionairesModel({
    this.question,
    this.answer,
  });

  QuestionairesModel.fromJson(Map<dynamic, dynamic> json) {
    if (json != null && json.length > 0) {
      this.question = json["question"];
      this.answer = json["answer"];
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map();
    data["question"] = question;
    data["answer"] = answer;
    return data;
  }
}

extension MyStringExtension on String {
  String get formateCaseStatusStr {
    //pending/reportReady/needUpdate

    if (this.toLowerCase() == "reportready") {
      return "REPORT READY";
    } else if (this.toLowerCase() == "needupdate") {
      return "NEED UPDATE";
    } else {
      return this.toUpperCase();
    }
  }

  Color get formateCaseStatusColor {
    //pending/reportReady/needUpdate

    if (this.toLowerCase() == "reportready") {
      return CustomColors.green;
    } else if (this.toLowerCase() == "needupdate") {
      return CustomColors.red;
    } else {
      return CustomColors.yellow2;
    }
  }

  IconData get formateCaseStatusIcon {
    //pending/reportReady/needUpdate

    if (this.toLowerCase() == "reportready") {
      return Moru.smile;
    } else if (this.toLowerCase() == "needupdate") {
      return Moru.teeth_calen;
    } else {
      return Moru.teeth_cross;
    }
  }

  Color get formateCaseStatusBackground {
    //pending/reportReady/needUpdate

    if (this.toLowerCase() == "reportready") {
      return CustomColors.yellow2;
    } else if (this.toLowerCase() == "needupdate") {
      return CustomColors.red;
    } else {
      return CustomColors.primarycolor;
    }
  }
}
