import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final String name;
  final String photoURL;
  final double height;
  final bool isButton;
  final String email;

  ContactCard(
      {Key key,
      this.name,
      this.photoURL,
      @required this.height,
      this.isButton,
      this.email});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color(0xFF00234D),
        borderOnForeground: true,
        child: Row(
          children: [
            Image.network(photoURL),
            Container(
              padding: EdgeInsets.only(left: 20),
              height: height,
              child: Column(
                children: [
                  Text(
                    name,
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  Text(
                    email != null ? email : "From your contact agenda",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
