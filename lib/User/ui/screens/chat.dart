import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:skype_clone/User/bloc/bloc_user.dart';
import 'package:skype_clone/User/model/user.dart';
import 'package:skype_clone/User/ui/widgets/messaging_textfield.dart';
import 'package:skype_clone/widgets/gradient_back.dart';

class ChatListScreen extends StatefulWidget {
  final UserModel receiver;

  ChatListScreen({@required this.receiver});
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
          title: Text(widget.receiver.name),
          backgroundColor: Color(0xFF00234D),
          leading: Icon(Icons.arrow_back),
          actions: [
            Container(
                padding: EdgeInsets.all(8), child: Icon(Icons.video_call)),
            Container(padding: EdgeInsets.all(8), child: Icon(Icons.phone))
          ],
        ),
        body: Stack(
          children: [
            Flexible(child: GradientBack()),
            Column(
              children: [
                Flexible(child: messageList(userBloc.currentUser.uid)),
                MessagingTextfield(receiver: widget.receiver, sender: sender)
              ],
            ),
          ],
        ));
  }

  Widget messageList(String _currentUserId) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("messages")
          .doc(_currentUserId)
          .collection(widget.receiver.uid)
          .orderBy("timestamp", descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            chatMessageItem(snapshot.data.docs[index], _currentUserId);
          },
        );
      },
    );
  }

  Widget chatMessageItem(DocumentSnapshot snapshot, String _currentUserId) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Container(
        alignment: snapshot.get('senderId') == _currentUserId
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: snapshot.get('senderId') == _currentUserId
            ? senderLayout(snapshot)
            : receiverLayout(snapshot),
      ),
    );
  }

  Widget receiverLayout(DocumentSnapshot snapshot) {
    Radius messageRadius = Radius.circular(10);

    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.only(
              topLeft: messageRadius,
              topRight: messageRadius,
              bottomLeft: messageRadius)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: getMessage(snapshot),
      ),
    );
  }

  Widget senderLayout(DocumentSnapshot snapshot) {
    Radius messageRadius = Radius.circular(10);

    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
              topLeft: messageRadius,
              topRight: messageRadius,
              bottomLeft: messageRadius)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: getMessage(snapshot),
      ),
    );
  }

  getMessage(DocumentSnapshot snapshot) {
    return Text(
      snapshot.get('message'),
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
    );
  }
}
