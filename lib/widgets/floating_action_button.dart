import 'package:flutter/material.dart';

class FloatingActionCustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Add your onPressed code here!
      },
      child: Icon(Icons.edit),
      backgroundColor: Colors.blue,
    );
  }
}
