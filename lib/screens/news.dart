import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../info/newsdetail.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      
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
              DefaultAssetBundle.of(context).loadString("assets/newsdata.json"),
        ),
      ),
    );
  }

  Widget MyBox(String title, String subtitle, String img_url, String detail) {
  
  return Container(
    margin: EdgeInsets.only(bottom: 20),
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
    child: GestureDetector(
      onTap: () {
        print("next page >>");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Detailspage(title, subtitle, img_url, detail),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Montserrat',
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontFamily: 'Montserrat',
            ),
          ),
          Spacer(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     ElevatedButton(
          //       onPressed: () {
          //         print("favorite");
          //       },
          //       child: Icon(Icons.favorite_border),
          //       style: ElevatedButton.styleFrom(
          //         primary: Colors.white,
          //         onPrimary: Colors.red,
          //         shape: CircleBorder(),
          //         padding: EdgeInsets.all(10),
          //       ),
          //     ),
          //     ElevatedButton(
          //       onPressed: () {
          //         print("share");
          //       },
          //       child: Icon(Icons.share),
          //       style: ElevatedButton.styleFrom(
          //         primary: Colors.white,
          //         onPrimary: Color.fromARGB(255, 0, 110, 255),
          //         shape: CircleBorder(),
          //         padding: EdgeInsets.all(10),
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    ),
  );
}

}