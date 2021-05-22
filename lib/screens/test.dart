import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Attributes {
  final int userId;
  final int id;
  final String title;
  final bool completedStatus;

  Attributes({
    this.userId,
    this.id,
    this.title,
    this.completedStatus,
  });
}

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  String data = 'Hello world';
  int counter = 0;
  bool isLoading = false;
  List<Attributes> _newAttribute = [];

  Future<void> _testCalling() async {
    setState(() {
      counter++;
      isLoading = true;
    });

    var url = Uri.parse('https://jsonplaceholder.typicode.com/todos/$counter');

    var response = await http.get(url);
    final responseData = json.decode(response.body);
    print(responseData);

    setState(() {
      isLoading = false;
      //data = responseData['title'];
      _newAttribute.add(Attributes(
          userId: responseData['userId'],
          id: responseData['id'],
          title: responseData['title'],
          completedStatus: responseData['completed']));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Practice $counter'),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: _newAttribute.isEmpty
                  ? Image.network(
                      'https://raw.githubusercontent.com/devesh0605/devesh0605/main/profile-pic.png',
                      fit: BoxFit.cover,
                    )
                  : Scrollbar(
                      isAlwaysShown: true,
                      showTrackOnHover: true,
                      child: ListView.builder(
                          itemCount: _newAttribute.length,
                          itemBuilder: (ctx, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    child: Text('${_newAttribute[index].id}'),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child:
                                        Text('${_newAttribute[index].userId}'),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: Text(
                                        '${_newAttribute[index].completedStatus}'),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child:
                                        Text('${_newAttribute[index].title}'),
                                    flex: 3,
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.local_phone),
        onPressed: _testCalling,
      ),
    );
  }
}
