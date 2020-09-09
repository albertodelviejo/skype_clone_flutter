import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:skype_clone/User/bloc/bloc_user.dart';

class ContactsScreen extends StatefulWidget {
  ContactsScreen({Key key}) : super(key: key);
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(),
    );
  }
}
