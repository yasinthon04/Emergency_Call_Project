import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(25, 25, 25, 10),
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(60),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage("https://cdn1.iconfinder.com/data/icons/user-pictures/101/malecostume-512.png")),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 5, color: Colors.white),
                      color: Colors.white,
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black12,
                      //     blurRadius: 20,
                      //     offset: const Offset(
                      //       5,
                      //       5,
                      //     ),
                      //   )
                      // ]
                      ),
                  // child: Icon(
                  //   Icons.person,
                  //   size: 80,
                  //   color: Colors.grey.shade300,
                  // ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Mr. Nickolas West',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  '14 February 2001',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600]),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "User Information",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Card(
                      child: Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: <Widget>[
                            // ListTile(
                            //   contentPadding: EdgeInsets.symmetric(
                            //       horizontal: 12, vertical: 4),
                            //   leading: Icon(Icons.my_location),
                            //   title: Text("Location"),
                            //   subtitle: Text("USA"),
                            // ),
                            ListTile(
                              // leading: Icon(Icons.person),
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text("ABOUT ME"),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Age: 22 years old'),
                                  Text('Height: 170 cm'),
                                  Text('Weight: 60 kg'),
                                  Text('Bood Type: O')
                                ],
                              ),
                            ),
                            ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text("DISEA /SYMPTOM"),
                              ),
                              subtitle: Text("Blood Pressure"),
                            ),
                            ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text("ADDRESS"),
                              ),
                              subtitle: Text("916 Water St, Ketchikan, Alaska 99901, USA")
                            ),
                            // ListTile(
                            //   leading: Icon(Icons.email),
                            //   title: Text("Email"),
                            //   subtitle: Text("donaldtrump@gmail.com"),
                            // ),
                            // ListTile(
                            //   leading: Icon(Icons.phone),
                            //   title: Text("Phone"),
                            //   subtitle: Text("99--99876-56"),
                            // ),
                          ],
                        ),
                      ),
                    )
                  ]),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
