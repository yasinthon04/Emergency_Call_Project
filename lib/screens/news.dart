import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../newsinfo/detail.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = json.decode(snapshot.data.toString());
                  return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return MyBox(
                            data[index]['title'],
                            data[index]['subtitle'],
                            data[index]['img_url'],
                            data[index]['detail']);
                      },
                      itemCount: data.length);
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                // if snapshot.data is null or still loading, return a progress indicator
                return Center(child: CircularProgressIndicator());
              },
              future:
                  DefaultAssetBundle.of(context).loadString("assets/data.json"),
            )));
  }

  Widget MyBox(String title, String subtitle, String img_url, String detail) {
    var v1, v2, v3, v4;
    v1 = title;
    v2 = subtitle;
    v3 = img_url;
    v4 = detail;
    return Container(
    margin: EdgeInsets.only(top: 20),
    padding: EdgeInsets.all(20),
    height: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 2), // changes position of shadow
        ),
      ],
      image: DecorationImage(
        image: NetworkImage(img_url),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5), BlendMode.darken),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                print("next page >>");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Detailspage(title, subtitle, img_url, detail),
                  ),
                );
              },
              child: Text("Read more"),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 255, 74, 74), 
                onPrimary: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
}
