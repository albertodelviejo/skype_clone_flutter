import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:skype_clone/User/bloc/bloc_user.dart';
import 'package:skype_clone/User/model/message.dart';
import 'package:skype_clone/User/model/user.dart';

class MessagingTextfield extends StatefulWidget {
  final UserModel receiver;
  final UserModel sender;

  MessagingTextfield({Key key, this.receiver, this.sender});

  @override
  _MessagingTextfieldState createState() => _MessagingTextfieldState();
}

class _MessagingTextfieldState extends State<MessagingTextfield> {
  TextEditingController textEditingController = TextEditingController();
  bool isWriting = false;
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    userBloc = BlocProvider.of(context);

    setWritingTo(bool val) {
      setState(() {
        isWriting = val;
      });
    }

    return Container(
      width: screenWidht,
      color: Color(0xFF00234D),
      height: 60.0,
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blueAccent),
              child: Icon(
                Icons.add,
                color: Colors.white,
              )),
          SizedBox(
            width: 5,
          ),
          Expanded(
              child: TextField(
            controller: textEditingController,
            style: TextStyle(color: Colors.white),
            onChanged: (value) => () {
              (value.length > 0 && value.trim() != "")
                  ? setWritingTo(true)
                  : setWritingTo(false);
            },
            decoration: InputDecoration(
                hintText: "Type a message...",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                    borderSide: BorderSide.none),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                filled: true,
                fillColor: Colors.blueGrey[900],
                suffixIcon: GestureDetector(
                  onTap: () => {},
                  child: Icon(Icons.face, color: Colors.white),
                )),
          )),
          isWriting
              ? Container()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.record_voice_over, color: Colors.white),
                ),
          isWriting ? Container() : Icon(Icons.camera_alt, color: Colors.white),
          isWriting
              ? Container(
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent, shape: BoxShape.circle),
                  child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () => sendMessage(),
                    iconSize: 15,
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  sendMessage() {
    var text = textEditingController.text;

    Message _message = Message(
        receiverId: widget.receiver.uid,
        senderId: widget.sender.uid,
        message: text,
        timeStamp: FieldValue.serverTimestamp(),
        type: 'text');

    setState(() {
      isWriting = false;
    });

    userBloc.addMessageToDb(_message, widget.sender, widget.receiver);
  }
}
