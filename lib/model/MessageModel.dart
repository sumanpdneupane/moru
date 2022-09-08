import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moru/model/UserModel.dart';

class MessageModel {
  UserModel? sender;
  String?
      time; // Would usually be type DateTime or Firebase Timestamp in production apps
  String? text;
  String? image;
  bool? isLiked;
  bool? unread;

  MessageModel({
    this.sender,
    this.time,
    this.text,
    this.image,
    this.isLiked,
    this.unread,
  });
}

// YOU - current user
final UserModel currentUser = UserModel.fromJson(
  "nckjnjkv",
  {
    "fullname": "Suman",
    "email": "suman@gmail.com",
    "role": "patient",
    "createdDate": Timestamp.now(),
    "imageUrl": "",
  },
);

// USERS
final UserModel greg = UserModel.fromJson(
  "nckjnjkv1",
  {
    "fullname": "greg",
    "email": "greg@gmail.com",
    "role": "patient",
    "createdDate": Timestamp.now(),
    "imageUrl": "",
  },
);
final UserModel james = UserModel.fromJson(
  "nckjnjkv2",
  {
    "fullname": "james",
    "email": "james@gmail.com",
    "role": "patient",
    "createdDate": Timestamp.now(),
    "imageUrl": "",
  },
);
final UserModel john = UserModel.fromJson(
  "nckjnjkv3",
  {
    "fullname": "john",
    "email": "john@gmail.com",
    "role": "patient",
    "createdDate": Timestamp.now(),
    "imageUrl": "",
  },
);
final UserModel olivia = UserModel.fromJson(
  "nckjnjkv4",
  {
    "fullname": "olivia",
    "email": "olivia@gmail.com",
    "role": "patient",
    "createdDate": Timestamp.now(),
    "imageUrl": "",
  },
);
final UserModel sam = UserModel.fromJson(
  "nckjnjkv6",
  {
    "fullname": "sam",
    "email": "sam@gmail.com",
    "role": "patient",
    "createdDate": Timestamp.now(),
    "imageUrl": "",
  },
);
final UserModel sophia = UserModel.fromJson(
  "nckjnjkv7",
  {
    "fullname": "sophia",
    "email": "sophia@gmail.com",
    "role": "patient",
    "createdDate": Timestamp.now(),
    "imageUrl": "",
  },
);
final UserModel steven = UserModel.fromJson(
  "nckjnjkv8",
  {
    "fullname": "steven",
    "email": "steven@gmail.com",
    "role": "patient",
    "createdDate": Timestamp.now(),
    "imageUrl": "",
  },
);

// FAVORITE CONTACTS
List<UserModel> favorites = [sam, steven, olivia, john, greg];

// EXAMPLE CHATS ON HOME SCREEN
List<MessageModel> chats = [
  MessageModel(
    sender: james,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA3OcrgLb3Qw-uusc3euRX7HS6jP426-gdrsxu8PO6&s",
    isLiked: false,
    unread: true,
  ),
  MessageModel(
    sender: olivia,
    time: '4:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
  ),
  MessageModel(
    sender: john,
    time: '3:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  MessageModel(
    sender: sophia,
    time: '2:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
  ),
  MessageModel(
    sender: steven,
    time: '1:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  MessageModel(
    sender: sam,
    time: '12:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  MessageModel(
    sender: greg,
    time: '11:30 AM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<MessageModel> messages = [
  MessageModel(
    sender: james,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: true,
    unread: true,
  ),
  MessageModel(
    sender: currentUser,
    time: '4:30 PM',
    text: 'Just walked my doge. She was super duper cute. The best pupper!!',
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA3OcrgLb3Qw-uusc3euRX7HS6jP426-gdrsxu8PO6&s",
    isLiked: false,
    unread: true,
  ),
  MessageModel(
    sender: james,
    time: '3:45 PM',
    text: 'How\'s the doggo?',
    isLiked: false,
    unread: true,
  ),
  MessageModel(
    sender: james,
    time: '3:15 PM',
    text: 'All the food',
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA3OcrgLb3Qw-uusc3euRX7HS6jP426-gdrsxu8PO6&s",
    isLiked: true,
    unread: true,
  ),
  MessageModel(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Nice! What kind of food did you eat?',
    isLiked: false,
    unread: true,
  ),
  MessageModel(
    sender: james,
    time: '2:00 PM',
    text: 'I ate so much food today.',
    isLiked: false,
    unread: true,
  ),
];
