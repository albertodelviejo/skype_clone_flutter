import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00234D),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context)),
        actions: [
          FlatButton(
              onPressed: null,
              child: Text(
                "Sign Out",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ))
        ],
      ),
    );
  }
}
