import 'dart:io';

class CaseModel {
  String? uid;

  String? assignedTo;
  String? whatYouCanDo;
  String? replyFromDoctor;
  String? replyFromPatient;
  int? severityScale;

  DateTime? createdDate;
  DateTime? lastStatusUpdated;
  String? nextSteps;

  double? totalCostOfPlan;
  double? totalCostPaid;
  double? discountAmount;
  String? priceId;
  String? productId;
  String? coupon;
  dynamic stripeResponse;

  String? plan; //singleTissue/fullAssessment
  static String SINGLE_ISSUE_PLAN = "singleTissue";
  static String FULL_ASSESSMENT_PLAN = "fullAssessment";

  String? status; //pending/reportReady/needUpdate

  //For photo
  int lowerPhotoBoundSize;
  int upperPhotoBoundSize;
  List<PhotoModel>? photos;

  List<QuestionairesModel>? questionaires;
  List<String>? recommendedProducts = [];
  List<String>? recommendedTreatments = [];

  CaseModel({
    this.uid,
    this.assignedTo,
    this.whatYouCanDo,
    this.replyFromDoctor,
    this.replyFromPatient,
    this.severityScale,
    this.createdDate,
    this.lastStatusUpdated,
    this.nextSteps,
    this.coupon,
    this.stripeResponse,
    this.totalCostOfPlan = 0,
    this.totalCostPaid = 0,
    this.discountAmount = 0,
    this.plan,
    this.status,
    this.lowerPhotoBoundSize = 1,
    this.upperPhotoBoundSize = 2,
    List<PhotoModel>? photos,
    List<QuestionairesModel>? questionaires,
    this.recommendedProducts,
    this.recommendedTreatments,
  }) {
    this.photos = photos == null ? [] : photos;
    this.questionaires = questionaires == null ? [] : questionaires;
  }
}

class PhotoModel {
  String? description;
  String? title;
  String? url;
  String? status; //active/rejected
  File? file;

  static String ACTIVE = "active";
  static String REJECTED = "rejected";

  PhotoModel({
    required this.description,
    required this.status,
    required this.title,
    required this.url,
    this.file = null,
  });

  PhotoModel copyWith({
    String? description,
    String? title,
    String? url,
    String? status, //active/rejected
    File? file,
  }) {
    return PhotoModel(
        description: this.description = description ?? this.description,
        title: this.title = title ?? this.title,
        url: this.url = url ?? this.url,
        status: this.status = status ?? this.status,
        file: this.file = file ?? this.file);
  }
}

class QuestionairesModel {
  String? question;
  String? answer;

  QuestionairesModel({
    this.question,
    this.answer,
  });
}
