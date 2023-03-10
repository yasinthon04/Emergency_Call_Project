import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Detailspage extends StatefulWidget {
  final v1, v2, v3, v4;
  Detailspage(this.v1, this.v2, this.v3, this.v4);

  @override
  _DetailspageState createState() => _DetailspageState();
}

class _DetailspageState extends State<Detailspage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 74, 74),
        centerTitle: true,
        title: Text("Details"),
      ),
      body: SingleChildScrollView(
        
      ),
    );
  }
}
