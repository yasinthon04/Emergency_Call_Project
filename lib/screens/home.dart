import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'dart:convert';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<Map<String, dynamic>> items = [];

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   Future<void> loadData() async {
//   try {
//     final file = await rootBundle.loadString('assets/contactdata.json');
//     final data = jsonDecode(file).cast<Map<String, dynamic>>();
//     setState(() {
//       items = data;
//     });
//   } catch (e) {
//     print('Error loading data: $e');
//   }
//   }

//   void makeCall(String phoneNumber) async {
//     final url = 'tel:$phoneNumber';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // return Scaffold(
//     //   body: ListView.builder(
//     //     itemBuilder: (BuildContext context, int index) {
//     //       final item = items[index];
//     //       return Card(
//     //         child: ListTile(
//     //           leading: Icon(
//     //             Icons.person,
//     //             color: Color.fromARGB(255, 0, 0, 0),
//     //           ),
//     //           title: Text(item['name']),
//     //           subtitle: Text('${item['tell']}'),
//     //           onTap: () {
//     //             makeCall(item['tell']);
//     //           },
              
//     //         ),
//     //       );
//     //     },
//     //     itemCount: items.length,
//     //   ),
//     // );
//     return MaterialApp(
//   home: DefaultTabController(
//     length: 3,
//     child: Scaffold(
//       appBar: AppBar(
//         bottom: const TabBar(
//           tabs: [
//             Tab(icon: Icon(Icons.directions_car)),
//             Tab(icon: Icon(Icons.directions_transit)),
//             Tab(icon: Icon(Icons.directions_bike)),
//           ],
//         ),
//       ),
//     ),
//   ),
// );
//   }
// }

void main() {
  runApp(const TabBarDemo());
}

void _launchPhoneApp(String phoneNumber) async {
  if (await canLaunch(phoneNumber)) {
    await launch(phoneNumber);
  } else {
    throw 'Could not launch $phoneNumber';
  }
}

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final number = '+12345567890';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 237, 109, 109), 
          body: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: "Emergency Contacts"),
                  Tab(text: "Personal Contacts"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Container(
                      child: ListView(
                        children: <Widget>[
                          Card(
                            child: ListTile(
                              leading: Icon(Icons.person),
                              title: Text("John Smith"),
                              subtitle: Text("Emergency Contact"),
                              trailing: Icon(Icons.phone),
                              onTap: () async {
                                launch('tel://$number');

                                await FlutterPhoneDirectCaller.callNumber(number);
                                // Do something when the user taps the ListTile
                              },
                            ),
                          ),
                          Card(
                            child: ListTile(
                              leading: Icon(Icons.person),
                              title: Text("Jane Doe"),
                              subtitle: Text("Emergency Contact"),
                              trailing: Icon(Icons.phone),
                              onTap: () {
                                // Do something when the user taps the ListTile
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: ListView(
                        children: <Widget>[
                          Card(
                            child: ListTile(
                              leading: Icon(Icons.person),
                              title: Text("Bob Johnson"),
                              subtitle: Text("Personal Contact"),
                              trailing: Icon(Icons.phone),
                              onTap: () {
                                // Do something when the user taps the ListTile
                              },
                            ),
                          ),
                          Card(
                            child: ListTile(
                              leading: Icon(Icons.person),
                              title: Text("Mary Smith"),
                              subtitle: Text("Personal Contact"),
                              trailing: Icon(Icons.phone),
                              onTap: () {
                                // Do something when the user taps the ListTile
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}