import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:skype_clone/User/bloc/bloc_user.dart';
import 'package:skype_clone/User/model/user.dart';
import 'package:skype_clone/User/ui/widgets/messaging_textfield.dart';
import 'package:skype_clone/widgets/gradient_back.dart';

class ChatListScreen extends StatefulWidget {
  final UserModel receiver;

  ChatListScreen({this.receiver});
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    UserModel sender = UserModel(
        uid: userBloc.currentUser.uid,
        name: userBloc.currentUser.displayName,
        email: userBloc.currentUser.email,
        photoURL: userBloc.currentUser.photoURL,
        searchKey: userBloc.currentUser.displayName.substring(0, 1));
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
            MessagingTextfield(receiver: widget.receiver, sender: sender),
          ],
        ));
  }
}
