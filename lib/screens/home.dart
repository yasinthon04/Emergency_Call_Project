import 'package:emc/info/contactdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'dart:convert';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:emc/screens/map.dart';

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
      title: Text(name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Phone number: $number"),
          SizedBox(height: 10),
          Text("Relation: $relation"),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 32,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => map()),
            );
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

class ContactSearch extends SearchDelegate<Contact> {
  final List<Contact> contacts;

  ContactSearch({required this.contacts});

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
        close(context, Contact(name: '', number: '', relation: ''));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = contacts.where((contact) =>
        contact.name.toLowerCase().contains(query.toLowerCase()) ||
        contact.number.contains(query));
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final contact = results.elementAt(index);
        return ListTile(
          leading: Icon(Icons.person),
          title: Text(contact.name),
          subtitle: Text(contact.relation),
          trailing: IconButton(
            icon: Icon(Icons.phone),
            onPressed: () async {
              // Call the phone number
              await FlutterPhoneDirectCaller.callNumber(contact.number);
            },
          ),
          onTap: () {
            Navigator.of(context).pop(contact);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = contacts.where((contact) =>
        contact.name.toLowerCase().contains(query.toLowerCase()) ||
        contact.number.contains(query));
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final contact = results.elementAt(index);
        return ListTile(
          leading: Icon(Icons.person),
          title: Text(contact.name),
          subtitle: Text(contact.relation),
          trailing: IconButton(
            icon: Icon(Icons.phone),
            onPressed: () async {
              // Call the phone number
              await FlutterPhoneDirectCaller.callNumber(contact.number);
            },
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ContactDetailPopup(
                  name: contact.name,
                  number: contact.number,
                  relation: contact.relation,
                );
              },
            );
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
                                  onTap: () async {
                        print("search");
                        // Load the contacts from the JSON files
                        final emergencyContacts =
                            await loadEmergencyContactsFromJson();
                        final personalContacts =
                            await loadPersonalContactsFromJson();
                        final allContacts = [
                          ...emergencyContacts,
                          ...personalContacts
                        ];
                        // Show the search delegate with the loaded contacts
                        showSearch(
                          context: context,
                          delegate: ContactSearch(contacts: allContacts),
                        );
                      },
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
                    FutureBuilder<List<Contact>>(
                      future: loadEmergencyContactsFromJson(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final contacts = snapshot.data!;
                          return ListView.builder(
                            itemCount: contacts.length,
                            itemBuilder: (context, index) {
                              final contact = contacts[index];
                              return Card(
                                child: ListTile(
                                  leading: Icon(Icons.person),
                                  title: Text(contact.name),
                                  subtitle: Text(contact.relation),
                                  trailing: IconButton(
                                    icon: Icon(Icons.phone),
                                    onPressed: () async {
                                      // Call the phone number
                                      await FlutterPhoneDirectCaller.callNumber(
                                          contact.number);
                                    },
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ContactDetailPopup(
                                          name: contact.name,
                                          number: contact.number,
                                          relation: contact.relation,
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                    FutureBuilder<List<Contact>>(
                      future: loadPersonalContactsFromJson(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final contacts = snapshot.data!;
                          return ListView.builder(
                            itemCount: contacts.length,
                            itemBuilder: (context, index) {
                              final contact = contacts[index];
                              return Card(
                                child: ListTile(
                                  leading: Icon(Icons.person),
                                  title: Text(contact.name),
                                  subtitle: Text(contact.relation),
                                  trailing: IconButton(
                                    icon: Icon(Icons.phone),
                                    onPressed: () async {
                                      // Call the phone number
                                      await FlutterPhoneDirectCaller.callNumber(
                                          contact.number);
                                    },
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ContactDetailPopup(
                                          name: contact.name,
                                          number: contact.number,
                                          relation: contact.relation,
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Contact {
  final String name;
  final String number;
  final String relation;

  Contact({
    required this.name,
    required this.number,
    required this.relation,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'],
      number: json['number'],
      relation: json['relation'],
    );
  }
}

List<Contact> parseContacts(String jsonString) {
  final parsed = jsonDecode(jsonString).cast<Map<String, dynamic>>();
  return parsed.map<Contact>((json) => Contact.fromJson(json)).toList();
}

Future<List<Contact>> loadEmergencyContactsFromJson() async {
  final String jsonString =
      await rootBundle.loadString('assets/emergency_contacts.json');
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList.map((json) => Contact.fromJson(json)).toList();
}

Future<List<Contact>> loadPersonalContactsFromJson() async {
  final String jsonString =
      await rootBundle.loadString('assets/personal_contacts.json');
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList.map((json) => Contact.fromJson(json)).toList();
}
