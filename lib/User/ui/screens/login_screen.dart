import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:skype_clone/User/bloc/bloc_user.dart';
import 'package:skype_clone/User/model/user.dart';
import 'package:skype_clone/User/ui/screens/home.dart';
import 'package:skype_clone/widgets/button_green.dart';
import 'package:skype_clone/widgets/gradient_back.dart';

class LogInScreen extends StatefulWidget {
  @override
  State createState() {
    return _LogInScreen();
  }
}

class _LogInScreen extends State<LogInScreen> {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession() {
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return signInGoogleUI();
        } else {
          return Home();
        }
      },
    );
  }

  Widget signInGoogleUI() {
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
                    onPressed: () {
                      userBloc.signOut();
                      userBloc.signIn().then((User user) {
                        userBloc.updateUserData(UserModel(
                            uid: user.uid,
                            searchKey: user.displayName.substring(0, 1),
                            name: user.displayName,
                            email: user.email,
                            photoURL: user.photoURL));
                      });
                    }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
