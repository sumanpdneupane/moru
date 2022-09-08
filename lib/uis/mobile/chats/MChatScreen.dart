import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moru/Routes.dart';
import 'package:moru/custom_widgets/MyInputField.dart';
import 'package:moru/custom_widgets/base_uis/BaseUIWidget.dart';
import 'package:moru/custom_widgets/dialogs/OpenCameraFileBottomDialog.dart';
import 'package:moru/libraries/FileManger.dart';
import 'package:moru/model/AppViewModel.dart';
import 'package:moru/model/MessageModel.dart';
import 'package:moru/model/UserModel.dart';
import 'package:moru/utils/Commons.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:moru/utils/MoruIcons.dart';
import 'package:moru/model/MessageModel.dart';
import 'package:provider/provider.dart';
import 'package:moru/model/CaseModel.dart';

class MChatScreen extends StatefulWidget {
  MChatScreen();

  @override
  _MChatScreenState createState() => _MChatScreenState();
}

class _MChatScreenState extends State<MChatScreen> {
  TextEditingController messageController = TextEditingController();
  CaseModel? caseModel;
  UserModel? currentUser;
  String fullName = "";
  String? photo;

  @override
  void initState() {
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);
    currentUser = userViewModel.getModel();

    var viewModel = Provider.of<AppViewModel>(context, listen: false);
    caseModel = viewModel.getSingleCaseCheckupModel();

    print("caseModel--initState---------> ${caseModel!.id}");

    getDoctor();
    super.initState();
  }

  getDoctor() async {
    var doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(caseModel!.assignedTo)
        .get();

    Map data = doc.data() as Map;
    fullName = data["fullName"];
    photo = data["photo"];
    setState(() {});
  }

  Future<void> sendMessage() async {
    var currentUserViewModel =
        Provider.of<UserViewModel>(context, listen: false);
    var model = currentUserViewModel.getModel();

    if (messageController.text.isNotEmpty) {
      MessageModel messageModel = MessageModel(
        receivedBy: "uid2",
        sendBy: model.uid,
        type: "text",
        caseId: caseModel!.id,
        value: messageController.text.trim(),
        createdDate: Timestamp.now().toDate(),
      );
      await FirebaseFirestore.instance.collection('chats').add(
            messageModel.toJson(),
          );
      messageController.text = "";
    }
  }

  Future openCameraOrGallery(BuildContext context) async {
    OpenCameraFileBottomDialog(
      context: context,
      fileType: FileType.image,
      allowExtensions: false,
      callback: (Uint8List bytes) async {
        if (bytes == null) {
          Commons.toastMessage(context, FileManger.NO_SELECTED);
        } else {
          EasyLoading.show(status: 'Uploading...');
          var currentUserViewModel =
              Provider.of<UserViewModel>(context, listen: false);
          var model = currentUserViewModel.getModel();

          String imageUrl = await uploadFile(bytes, caseModel!.id);
          if (imageUrl == "") {
            EasyLoading.dismiss();
            return;
          }
          MessageModel messageModel = MessageModel(
            receivedBy: "uid2",
            sendBy: model.uid,
            type: "photo",
            caseId: caseModel!.id,
            value: imageUrl,
            createdDate: Timestamp.now().toDate(),
          );

          await FirebaseFirestore.instance
              .collection('chats')
              .add(messageModel.toJson());
          EasyLoading.dismiss();
          //Commons.toastMessage(context, "Image sent");
        }
      },
    );
  }

  Future<String> uploadFile(Uint8List byte, String? caseId) async {
    try {
      final _firebaseStorage = FirebaseStorage.instance;
      print(
          'chats/${caseId}/${DateTime.now().microsecondsSinceEpoch}-moru.jpeg');
      var snapshot = await _firebaseStorage
          .ref()
          .child(
              'chats/${caseId}/${DateTime.now().microsecondsSinceEpoch}-moru.jpeg')
          .putData(
            byte,
            SettableMetadata(
              contentType: 'image/jpeg',
            ),
          )
          .whenComplete(() => null);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e);
      return '';
    }
  }

  Widget _buildMessageComposer() {
    return Container(
      height: 70.0,
      color: CustomColors.greyLight,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.add),
            color: Theme.of(context).primaryColor,
            iconSize: 25.0,
            onPressed: () {
              openCameraOrGallery(context);
            },
          ),
          Expanded(
            child: TextField(
              controller: messageController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: "Write a message... ",
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide.none,
                ),
                fillColor: CustomColors.white,
                //CustomColors.inputfillColor.withOpacity(0.07),
                filled: true,
                hintStyle: GoogleFonts.syne(
                  fontSize: 15.0,
                  color: CustomColors.inputfillColor,
                ),
                contentPadding: const EdgeInsets.only(left: 20, right: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
            iconSize: 25.0,
            onPressed: () {
              sendMessage();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(MessageModel message, bool isMe) {
    final msg = message.type == "text"
        ? Container(
            width: MediaQuery.of(context).size.width * 0.55,
            margin: isMe
                ? EdgeInsets.only(top: 3.0, bottom: 3.0, left: 80.0)
                : EdgeInsets.only(top: 3.0, bottom: 3.0, right: 10.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              decoration: BoxDecoration(
                color:
                    isMe ? CustomColors.primarycolor : CustomColors.greyLight,
                borderRadius: isMe
                    ? BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      )
                    : BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message.value != null && message.value != ""
                      ? Text(
                          "${message.value}",
                          style: GoogleFonts.syne(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                            color: isMe
                                ? CustomColors.white
                                : CustomColors.inputfillColor,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          )
        : Container();

    final image = message.type == "photo"
        ? Container(
            width: MediaQuery.of(context).size.width * 0.55,
            margin: isMe
                ? EdgeInsets.only(top: 3.0, bottom: 3.0, left: 80.0)
                : EdgeInsets.only(top: 3.0, bottom: 3.0, right: 10.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              decoration: BoxDecoration(
                color:
                    isMe ? CustomColors.primarycolor : CustomColors.greyLight,
                borderRadius: isMe
                    ? BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      )
                    : BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message.value != null && message.value != ""
                      ? Container(
                          height: 130,
                          //margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(message.value!),
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          )
        : Container();

    final time = Text(
      "${DateFormat("h:mm a").format(message.createdDate!)}",
      style: GoogleFonts.syne(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: CustomColors.black,
      ),
    );

    if (isMe)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          msg,
          image,
          time,
          SizedBox(height: 32),
        ],
      );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        msg,
        image,
        time,
        SizedBox(height: 32),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: width * 0.87,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Routes.pop(context);
                    },
                    child: Container(
                      height: 36,
                      width: 36,
                      //padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        //color: Colors.white,
                        border: Border.all(
                          color: CustomColors.primarycolor1.withOpacity(0.35),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                  SizedBox(width: 16),
                  // Container(
                  //   height: 42,
                  //   width: 42,
                  //   decoration: BoxDecoration(
                  //     color: Colors.amber,
                  //     borderRadius: BorderRadius.circular(24),
                  //   ),
                  //   child: Icon(
                  //     Icons.person,
                  //     color: Colors.white,
                  //     size: 17,
                  //   ),
                  // ),
                  photo != null && photo != ""
                      ? Container(
                          height: 40,
                          width: 40,
                          //margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(photo!),
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(width: 8),
                  Container(
                    height: 36,
                    //padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text(
                      "${fullName}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.syne(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: width * 0.87,
                margin: EdgeInsets.only(top: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ClipRRect(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('chats')
                        .where("caseId", isEqualTo: caseModel!.id)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.data!.docs.length < 1) {
                        return Container();
                      }

                      List<MessageModel> messages =
                          snapshot.data!.docs.map((doc) {
                        Map data = doc.data() as Map;
                        return new MessageModel.fromJson(doc.id, data);
                      }).toList();

                      messages.sort((a, b) {
                        return b.createdDate!.compareTo(a.createdDate!);
                      });

                      return ListView.builder(
                        reverse: true,
                        padding: EdgeInsets.only(top: 15.0),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final MessageModel message = messages[index];
                          final bool isMe = message.sendBy == currentUser!.uid;

                          print(
                            "QuerySnapshot----------> ${isMe}----${currentUser!.uid}--\n${message.toJson()}",
                          );

                          return _buildMessage(message, isMe);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
