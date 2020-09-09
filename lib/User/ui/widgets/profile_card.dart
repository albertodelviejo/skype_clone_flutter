import 'package:flutter/material.dart';
import 'package:skype_clone/User/model/user.dart';

class ProfileCard extends StatelessWidget {
  final UserModel userModel;

  ProfileCard({Key key, this.userModel});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color(0xFF00234D),
        borderOnForeground: true,
        child: Row(
          children: [
            Image.network(userModel.photoURL),
            Container(
              padding: EdgeInsets.only(left: 20),
              height: 40,
              child: Column(
                children: [
                  Text(
                    userModel.name,
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  Text(
                    userModel.email,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
