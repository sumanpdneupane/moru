import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/Routes.dart';
import 'package:moru/custom_widgets/MyInputField.dart';
import 'package:moru/custom_widgets/base_uis/BaseUIWidget.dart';
import 'package:moru/model/MessageModel.dart';
import 'package:moru/model/UserModel.dart';
import 'package:moru/utils/CustomColors.dart';
import 'package:moru/utils/MoruIcons.dart';
import 'package:moru/model/MessageModel.dart';

class MChatScreen extends StatefulWidget {
  UserModel? user;

  MChatScreen({
    this.user,
  });

  @override
  _MChatScreenState createState() => _MChatScreenState();
}

class _MChatScreenState extends State<MChatScreen> {
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
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              onChanged: (value) {},
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
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(MessageModel message, bool isMe) {
    final msg = message.text != null && message.text != ""
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
                  message.text != null && message.text != ""
                      ? Text(
                          "${message.text}",
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

    final image = message.image != null && message.image != ""
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
                  message.image != null && message.image != ""
                      ? Container(
                          height: 130,
                          //margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(message.image!),
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
      "${message.time}",
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
  void initState() {
    widget.user = olivia;
    super.initState();
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
                  SizedBox(width: 24),
                  Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 17,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    height: 36,
                    //padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text(
                      "Dr. Mariam",
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
                  child: ListView.builder(
                      reverse: true,
                      padding: EdgeInsets.only(top: 15.0),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final MessageModel message = messages[index];
                        final bool isMe =
                            message.sender!.uid == currentUser.uid;
                        return _buildMessage(message, isMe);
                      }),
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
