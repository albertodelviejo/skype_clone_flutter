import 'package:flutter/material.dart';
import 'package:skype_clone/User/ui/widgets/messaging_textfield.dart';
import 'package:skype_clone/widgets/gradient_back.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("test"),
          backgroundColor: Color(0xFF00234D),
          leading: Icon(Icons.arrow_back),
          actions: [
            Container(
                padding: EdgeInsets.all(8), child: Icon(Icons.video_call)),
            Container(padding: EdgeInsets.all(8), child: Icon(Icons.phone))
          ],
        ),
        body: Column(
          children: [
            Flexible(child: GradientBack()),
            MessagingTextfield(),
          ],
        ));
  }
}

Widget messageList() {
  return null;
}
