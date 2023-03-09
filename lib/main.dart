import 'package:emc/screens/home.dart';
import 'package:emc/screens/map.dart';
import 'package:emc/screens/news.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _currentIndex = 0;
  final tabs = [TabBarDemo(),MapPage(),NewsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 74, 74), 
          centerTitle: true, 
          leading: Icon(Icons.local_hospital), 
          title: Text("Emergency call")
          ),
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          selectedItemColor: Color.fromARGB(255, 255, 74, 74),
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Homepage"),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
            BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "News"),
            
            
          ],
          onTap: (index) {
            setState(() {
              print(index);
              _currentIndex = index;
            });
          },
        ));
  }
}