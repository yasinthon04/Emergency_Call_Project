import 'package:emc/info/contactdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'dart:convert';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

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

class ContactDetailPopup extends StatelessWidget {
  final String name;
  final String number;
  final String relation;

  ContactDetailPopup({
    required this.name,
    required this.number,
    required this.relation,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        name,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Montserrat',
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Phone number: $number",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 8),
            Text("Relationship: $relation"),
          ],
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.call,
            color: Colors.green,
            size: 32,
          ),
          onPressed: () async {
            // Get the phone number from your data source
            launch('tel://$number');
            // Call the phone number
            await FlutterPhoneDirectCaller.callNumber(number);
          },
        ),
        IconButton(
          icon: Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 32,
          ),
          onPressed: () {
            // TODO: Implement send location functionality
          },
        ),
        IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.red,
            size: 32,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class ContactSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Perform the search and display the results
    final List<String> contacts = [
      'John Smith',
      'Jane Doe',
      'Bob Johnson',
      'Mary Smith',
      'Tom Jones',
      'Sarah Wilson',
    ]; // replace with your actual list of contacts
    final List<String> searchResults = contacts
        .where((contact) => contact.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(Icons.person),
          title: Text(searchResults[index]),
          subtitle: Text("Contact"),
          trailing: Icon(Icons.phone),
          onTap: () async {
            String number =
                '+12345567890'; // replace with the actual phone number
            launch('tel://$number');
            await FlutterPhoneDirectCaller.callNumber(number);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Display suggestions as the user types in the search bar
    final List<String> contacts =
        []; // replace with your actual list of contacts
    final List<String> searchResults = query.isEmpty
        ? contacts // Show all contacts when query is empty
        : contacts
            .where((contact) =>
                contact.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(Icons.person),
          title: Text(searchResults[index]),
          subtitle: Text("Contact"),
          trailing: Icon(Icons.phone),
          onTap: () async {
            String number =
                '+12345567890'; // replace with the actual phone number
            launch('tel://$number');
            await FlutterPhoneDirectCaller.callNumber(number);
          },
        );
      },
    );
  }
}

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    final number = '+12345567890';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          body: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      "Emergency Contacts",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Personal Contacts",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.redAccent,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey[700],
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate: ContactSearch(),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 13),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child:
                                    Icon(Icons.search, color: Colors.grey[600]),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search contacts',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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
                              trailing: IconButton(
                                icon: Icon(Icons.phone),
                                onPressed: () async {
                                  // Get the phone number from your data source
                                  launch('tel://$number');
                                  // Call the phone number
                                  await FlutterPhoneDirectCaller.callNumber(
                                      number);
                                },
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ContactDetailPopup(
                                        name: "John Smith",
                                        number: "123-456-7890",
                                        relation: "Emergency Contact");
                                  },
                                );
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
