import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
  try {
    final file = await rootBundle.loadString('assets/contactdata.json');
    final data = jsonDecode(file).cast<Map<String, dynamic>>();
    setState(() {
      items = data;
    });
  } catch (e) {
    print('Error loading data: $e');
  }
  }

  void makeCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return Card(
            child: ListTile(
              leading: Icon(
                Icons.person,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              title: Text(item['name']),
              subtitle: Text('${item['tell']}'),
              onTap: () {
                makeCall(item['tell']);
              },
              
            ),
          );
        },
        itemCount: items.length,
      ),
    );
  }
}

