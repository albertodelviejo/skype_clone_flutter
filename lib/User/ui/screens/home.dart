import 'package:flutter/material.dart';
import 'package:skype_clone/User/ui/screens/profile_screen.dart';
import 'package:skype_clone/User/ui/screens/search_screen.dart';
import 'package:skype_clone/widgets/floating_action_button.dart';
import 'package:skype_clone/widgets/gradient_back.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget center_appbar = Icon(Icons.portrait);
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Chats',
      style: optionStyle,
    ),
    Text(
      'Index 1: Calls',
      style: optionStyle,
    ),
    Text(
      'Index 2: Contacts',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: center_appbar,
          ),
          backgroundColor: Color(0xFF00234D),
          leading: Icon(Icons.notifications),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()))),
            Icon(Icons.more_vert)
          ],
        ),
        body: Stack(
          children: [
            GradientBack(),
          ],
        ),
        floatingActionButton: FloatingActionCustomButton(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF00234D),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Chats'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              title: Text('Calls'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              title: Text('Contacts'),
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.blueGrey,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          center_appbar = IconButton(
              icon: Icon(Icons.portrait),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen())));
          break;
        case 1:
          center_appbar = Text("Calls");
          break;
        case 2:
          center_appbar = Text("Contacts");
          break;
      }
    });
  }
}
