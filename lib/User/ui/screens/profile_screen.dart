import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:skype_clone/User/bloc/bloc_user.dart';
import 'package:skype_clone/User/model/user.dart';
import 'package:skype_clone/User/ui/screens/login_screen.dart';
import 'package:skype_clone/User/ui/widgets/profile_card.dart';
import 'package:skype_clone/widgets/gradient_back.dart';

class ProfileScreen extends StatelessWidget {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    User firebaseUser = userBloc.currentUser;
    UserModel userModel = UserModel(
        uid: firebaseUser.uid,
        name: firebaseUser.displayName,
        email: firebaseUser.email,
        photoURL: firebaseUser.photoURL);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00234D),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context)),
        actions: [
          FlatButton(
              onPressed: () {
                userBloc.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => LogInScreen()));
              },
              child: Text(
                "Sign Out",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ))
        ],
      ),
      body: Stack(
        children: [
          GradientBack(height: null),
          ProfileCard(userModel: userModel)
        ],
      ),
    );
  }
}
