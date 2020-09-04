import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skype_clone/User/bloc/bloc_user.dart';
import 'package:skype_clone/User/model/user.dart';
import 'package:skype_clone/widgets/button_green.dart';
import 'package:skype_clone/widgets/gradient_back.dart';

class Login extends StatelessWidget {
  double screenWidht;
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        GradientBack(height: null),
      ],
    );
  }

  Widget loginColumns() {
    return Column(
      children: [
        Flexible(
          child: Container(
            width: screenWidht,
            child: Text(
              "Welcome \n This is your Travel App",
              style: TextStyle(
                  fontSize: 37.0,
                  fontFamily: "Lato",
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ButtonGreen(
          text: "Login with Gmail",
          onPressed: () {
            userBloc.signOut();
            userBloc.signIn().then((FirebaseUser user) {
              userBloc.updateUserData(User(
                  uid: user.uid,
                  name: user.displayName,
                  email: user.email,
                  photoURL: user.photoUrl));
            });
          },
          width: 300.0,
          height: 50.0,
        )
      ],
    );
  }
}
