import 'package:asistencia_v2/chat/index.dart';
import 'package:asistencia_v2/home/index.dart';
import 'package:asistencia_v2/profile/index.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  RootPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  var _currentPage = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (newPosition) {
          setState(() {
            _currentPage = newPosition;
          });
        },
        children: <Widget>[
          HomePage(),
          ChatPage(),
          ProfilePage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (newPosition) {
          setState(() {
            _currentPage = newPosition;
            _pageController.jumpToPage(_currentPage);
          });
        },
        currentIndex: _currentPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(title: Text("Home"), icon: Icon(Icons.home)),
          BottomNavigationBarItem(title: Text("Chat"), icon: Icon(Icons.chat)),
          BottomNavigationBarItem(
              title: Text("Profile"), icon: Icon(Icons.person))
        ],
      ),
    );
  }
}
