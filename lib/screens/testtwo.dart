import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestTwo extends StatefulWidget {
  @override
  _TestTwoState createState() => _TestTwoState();
}

class _TestTwoState extends State<TestTwo> {
  String someText = 'Hello World';
  String stringUrl = '';

  Future<void> callingApi() async {
    var url = Uri.parse('https://randomuser.me/api/');
    var response = await http.get(url);
    print(json.decode(response.body));
    setState(() {
      someText =
          json.decode(response.body)['results'][0]['name']['first'].toString();
      stringUrl = json
          .decode(response.body)['results'][0]['picture']['thumbnail']
          .toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Center(
        child: someText == 'Hello World'
            ? Text('No Data')
            : Image.network(stringUrl),
        // Text(
        //   someText,
        //   textAlign: TextAlign.center,
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.call),
        onPressed: callingApi,
      ),
    );
  }
}
