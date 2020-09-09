import 'package:flutter/material.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String photoURL;
  final String searchKey;

  UserModel(
      {Key key,
      @required this.uid,
      @required this.name,
      @required this.email,
      @required this.photoURL,
      @required this.searchKey});
}
