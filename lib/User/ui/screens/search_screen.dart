import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skype_clone/User/model/user.dart';
import 'package:skype_clone/User/repository/search_service.dart';
import 'package:skype_clone/User/ui/screens/chat.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; ++i) {
          print(docs.docs[i].data());
          queryResultSet.add(docs.docs[i].data());
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['name'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue[600],
          shadowColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context))),
      body: Column(
        children: [
          Container(
            color: Colors.blue[600],
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 10, left: 20.0, right: 20.0),
              child: TextField(
                onChanged: (val) {
                  initiateSearch(val);
                },
                cursorColor: Colors.white,
                maxLines: 1,
                style: TextStyle(color: Colors.white, fontSize: 35),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: tempSearchStore.map((e) {
              return buildResultCard(e, context);
            }).toList(),
          )
        ],
      ),
    );
  }
}

Widget buildResultCard(data, context) {
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2.0,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatListScreen(
                    receiver: UserModel(
                        name: data['name'],
                        email: data['email'],
                        photoURL: data['photoURL'],
                        uid: data['uid']))),
          );
        },
        child: Container(
          child: Center(
              child: Text(
            data['name'],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          )),
        ),
      ));
}
