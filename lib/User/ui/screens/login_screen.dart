import 'package:flutter/material.dart';
import 'package:skype_clone/widgets/button_green.dart';
import 'package:skype_clone/widgets/gradient_back.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GradientBack(height: null),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 170, left: 20, right: 20),
                child: Center(
                  child: Text(
                    "Welcome to Skype Clone",
                    style: TextStyle(color: Colors.white, fontSize: 50),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 90),
                child: ButtonGreen(
                  text: "Sign In with Google",
                  height: 50,
                  width: 270,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
