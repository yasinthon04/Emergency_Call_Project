import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Color _backgroundColor = Colors.white; // set initial background color

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            color: _backgroundColor,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(25, 25, 25, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      children: [
                        ScaleTransition(
                          scale: _animation,
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.8),
                                  blurRadius: 6.0,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.network(
                                "https://cdn1.iconfinder.com/data/icons/user-pictures/101/malecostume-512.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        FadeTransition(
                          opacity: _animation,
                          child: Text(
                            'Mr. Nickolas Smith',
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeTransition(
                          opacity: _animation,
                          child: Text(
                            '14 February 2001',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(children: <Widget>[
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 4.0),
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
                            ScaleTransition(
                                scale: _animation,
                                child: Card(
                                    child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: const Padding(
                                          padding: EdgeInsets.only(bottom: 5.0),
                                          child: Text("ABOUT ME"),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text('Age: 22 years old'),
                                            Text('Height: 170 cm'),
                                            Text('Weight: 60 kg'),
                                            Text('Blood Type: O')
                                          ],
                                        ),
                                      ),
                                      ListTile(
                                        title: const Padding(
                                          padding: EdgeInsets.only(bottom: 5.0),
                                          child: Text("DISEASE / SYMPTOMS"),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Blood Pressure'),
                                            const SizedBox(height: 5),
                                            LinearProgressIndicator(
                                              value: 0.6,
                                              backgroundColor: Colors.grey[300],
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.red),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              'Last checkup: 20 Jan 2022',
                                              style: TextStyle(
                                                  color: Colors.grey[600]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ListTile(
                                        title: const Padding(
                                          padding: EdgeInsets.only(bottom: 5.0),
                                          child: Text("ADDRESS"),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text('519 Oak St, Libertyville, Illinois 60048, USA'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )))
                          ]),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
