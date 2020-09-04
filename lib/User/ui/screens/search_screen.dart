import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue[600],
          shadowColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context))),
      body: Container(
        color: Colors.blue[600],
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 20.0, right: 20.0),
          child: TextField(
            cursorColor: Colors.white,
            maxLines: 1,
            style: TextStyle(color: Colors.white, fontSize: 35),
            decoration: InputDecoration(
              fillColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
