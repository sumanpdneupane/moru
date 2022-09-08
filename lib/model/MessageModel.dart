import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moru/model/UserModel.dart';

// caseId
// ""
// (string)
// createdDate
// September 1, 2022 at 12:00:00 AM UTC+5:45
// receivedBy
// "321321312"
// sendBy
// "2321312"
// type
// "text/photo"
// value
// ""

class MessageModel {
  String? id;
  DateTime? createdDate;
  String? receivedBy;
  String? sendBy;
  String? type; //"text/photo"
  String? value;
  String? caseId;

  MessageModel({
    this.id,
    this.createdDate,
    this.receivedBy,
    this.sendBy,
    this.type,
    this.value,
    this.caseId,
  });

  MessageModel.fromJson(String uid, Map<dynamic, dynamic> json) {
    this.id = uid;
    if (json != null && json.length > 0) {
      this.receivedBy = json["receivedBy"];
      this.sendBy = json["sendBy"];
      this.type = json["type"];
      this.value = json["value"];
      this.caseId = json["caseId"];
      final createdDate = json["createdDate"] as Timestamp;
      this.createdDate = createdDate != null ? createdDate.toDate() : null;
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map();
    data["receivedBy"] = receivedBy;
    data["sendBy"] = sendBy;
    data["type"] = type;
    data["value"] = value;
    data["caseId"] = caseId;
    data["createdDate"] = createdDate;
    return data;
  }
}
//
// // YOU - current user
// final UserModel currentUser = UserModel.fromJson(
//   "nckjnjkv",
//   {
//     "fullname": "Suman",
//     "email": "suman@gmail.com",
//     "role": "patient",
//     "createdDate": Timestamp.now(),
//     "imageUrl": "",
//   },
// );
//
// // USERS
// final UserModel greg = UserModel.fromJson(
//   "nckjnjkv1",
//   {
//     "fullname": "greg",
//     "email": "greg@gmail.com",
//     "role": "patient",
//     "createdDate": Timestamp.now(),
//     "imageUrl": "",
//   },
// );
// final UserModel james = UserModel.fromJson(
//   "nckjnjkv2",
//   {
//     "fullname": "james",
//     "email": "james@gmail.com",
//     "role": "patient",
//     "createdDate": Timestamp.now(),
//     "imageUrl": "",
//   },
// );
// final UserModel john = UserModel.fromJson(
//   "nckjnjkv3",
//   {
//     "fullname": "john",
//     "email": "john@gmail.com",
//     "role": "patient",
//     "createdDate": Timestamp.now(),
//     "imageUrl": "",
//   },
// );
// final UserModel olivia = UserModel.fromJson(
//   "nckjnjkv4",
//   {
//     "fullname": "olivia",
//     "email": "olivia@gmail.com",
//     "role": "patient",
//     "createdDate": Timestamp.now(),
//     "imageUrl": "",
//   },
// );
// final UserModel sam = UserModel.fromJson(
//   "nckjnjkv6",
//   {
//     "fullname": "sam",
//     "email": "sam@gmail.com",
//     "role": "patient",
//     "createdDate": Timestamp.now(),
//     "imageUrl": "",
//   },
// );
// final UserModel sophia = UserModel.fromJson(
//   "nckjnjkv7",
//   {
//     "fullname": "sophia",
//     "email": "sophia@gmail.com",
//     "role": "patient",
//     "createdDate": Timestamp.now(),
//     "imageUrl": "",
//   },
// );
// final UserModel steven = UserModel.fromJson(
//   "nckjnjkv8",
//   {
//     "fullname": "steven",
//     "email": "steven@gmail.com",
//     "role": "patient",
//     "createdDate": Timestamp.now(),
//     "imageUrl": "",
//   },
// );
//
// // FAVORITE CONTACTS
// List<UserModel> favorites = [sam, steven, olivia, john, greg];
//
// // EXAMPLE CHATS ON HOME SCREEN
// List<MessageModel> chats = [
//   MessageModel(
//     sender: james,
//     time: '5:30 PM',
//     text: 'Hey, how\'s it going? What did you do today?',
//     image:
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA3OcrgLb3Qw-uusc3euRX7HS6jP426-gdrsxu8PO6&s",
//     isLiked: false,
//     unread: true,
//   ),
//   MessageModel(
//     sender: olivia,
//     time: '4:30 PM',
//     text: 'Hey, how\'s it going? What did you do today?',
//     isLiked: false,
//     unread: true,
//   ),
//   MessageModel(
//     sender: john,
//     time: '3:30 PM',
//     text: 'Hey, how\'s it going? What did you do today?',
//     isLiked: false,
//     unread: false,
//   ),
//   MessageModel(
//     sender: sophia,
//     time: '2:30 PM',
//     text: 'Hey, how\'s it going? What did you do today?',
//     isLiked: false,
//     unread: true,
//   ),
//   MessageModel(
//     sender: steven,
//     time: '1:30 PM',
//     text: 'Hey, how\'s it going? What did you do today?',
//     isLiked: false,
//     unread: false,
//   ),
//   MessageModel(
//     sender: sam,
//     time: '12:30 PM',
//     text: 'Hey, how\'s it going? What did you do today?',
//     isLiked: false,
//     unread: false,
//   ),
//   MessageModel(
//     sender: greg,
//     time: '11:30 AM',
//     text: 'Hey, how\'s it going? What did you do today?',
//     isLiked: false,
//     unread: false,
//   ),
// ];
//
// // EXAMPLE MESSAGES IN CHAT SCREEN
// List<MessageModel> messages = [
//   MessageModel(
//     sender: james,
//     time: '5:30 PM',
//     text: 'Hey, how\'s it going? What did you do today?',
//     isLiked: true,
//     unread: true,
//   ),
//   MessageModel(
//     sender: currentUser,
//     time: '4:30 PM',
//     text: 'Just walked my doge. She was super duper cute. The best pupper!!',
//     image:
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA3OcrgLb3Qw-uusc3euRX7HS6jP426-gdrsxu8PO6&s",
//     isLiked: false,
//     unread: true,
//   ),
//   MessageModel(
//     sender: james,
//     time: '3:45 PM',
//     text: 'How\'s the doggo?',
//     isLiked: false,
//     unread: true,
//   ),
//   MessageModel(
//     sender: james,
//     time: '3:15 PM',
//     text: 'All the food',
//     image:
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA3OcrgLb3Qw-uusc3euRX7HS6jP426-gdrsxu8PO6&s",
//     isLiked: true,
//     unread: true,
//   ),
//   MessageModel(
//     sender: currentUser,
//     time: '2:30 PM',
//     text: 'Nice! What kind of food did you eat?',
//     isLiked: false,
//     unread: true,
//   ),
//   MessageModel(
//     sender: james,
//     time: '2:00 PM',
//     text: 'I ate so much food today.',
//     isLiked: false,
//     unread: true,
//   ),
// ];
