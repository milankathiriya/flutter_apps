import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:live_json_app/PODO.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

List<Album> postFromJson(String str) {
  var jsonData = json.decode(str);
  return List<Album>.from(jsonData.map((v) => Album.fromJson(v)));
}

const spinkit = SpinKitRotatingPlain(
  color: Colors.white,
  size: 50.0,
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    String url = "https://jsonplaceholder.typicode.com/photos";

    Future getAlbum() async {
      var response = await http.get(url);
      print(response.body);
      return postFromJson(response.body);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Live Json App"),
      ),
      body: FutureBuilder(
        future: getAlbum(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Text(
                      data[index].id.toString(),
                    ),
                    title: Text(data[index].title.toString()),
                    trailing: Image.network("${data[index].thumbnailUrl}"),
                  );
                });
          } else {
            return Container(color: Colors.blue, child: Center(child: spinkit));
          }
        },
      ),
    );
  }
}
