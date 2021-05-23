import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RandomUser {
  final String name;
  final String imageUrl;
  final int age;
  final String lastName;

  RandomUser({
    @required this.name,
    @required this.lastName,
    @required this.imageUrl,
    @required this.age,
  });
}

class TestTwo extends StatefulWidget {
  @override
  _TestTwoState createState() => _TestTwoState();
}

class _TestTwoState extends State<TestTwo> {
  String someText = 'NO data';
  String stringUrl = '';
  List<RandomUser> _randomData = [];
  bool isLoading = false;

  Future<void> callingApi() async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse('https://randomuser.me/api/');
    var response = await http.get(url);
    //print(_randomData);
    var structuredResponse = json.decode(response.body);
    setState(() {
      isLoading = false;
      _randomData.insert(
          0,
          RandomUser(
            imageUrl: structuredResponse['results'][0]['picture']['thumbnail'],
            name: structuredResponse['results'][0]['name']['first'],
            lastName: structuredResponse['results'][0]['name']['last'],
            age: structuredResponse['results'][0]['dob']['age'],
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your tasks'),
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : _randomData.isEmpty
              ? Center(
                  child: Text('NO DATA'),
                )
              : Scrollbar(
                  isAlwaysShown: true,
                  showTrackOnHover: true,
                  hoverThickness: 15,
                  child: ListView.builder(
                      itemCount: _randomData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          _randomData[index].imageUrl))),
                            ),
                            title: Text(
                                '${_randomData[index].name} ${_randomData[index].lastName}'),
                            subtitle: Text('${_randomData[index].age}'),
                            trailing: Icon(Icons.person),
                          ),
                        );
                      }),
                ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.call),
        onPressed: callingApi,
      ),
    );
  }
}

//class TaskDetail extends StatelessWidget {
//   final int userId;
//   final int id;
//   final String title;
//   final bool completed;
//
//   TaskDetail({
//     @required this.userId,
//     @required this.title,
//     @required this.id,
//     @required this.completed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(title: Text('Task Detail')),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text('$userId'),
//               SizedBox(
//                 height: 10,
//               ),
//               Text('$id'),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 '$title',
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 '$completed',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: completed ? Colors.green : Colors.red),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// .isEmpty
// ? Text(someText)
// : ListView.builder(
//     itemCount: randomData.length,
//     itemBuilder: (ctx, index) {
//       return Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 1,
//               child: Text(
//                 '${randomData[index]['id']}',
//               ),
//             ),
//             Divider(),
//             Expanded(
//               flex: 2,
//               child: Text(
//                 '${randomData[index]['name']}',
//               ),
//             ),
//             Divider(),
//             Expanded(
//               flex: 2,
//               child: Text(
//                 '${randomData[index]['address']['zipcode']}',
//               ),
//             ),
//             Divider(),
//             Expanded(
//               flex: 2,
//               child: Text(
//                 '${randomData[index]['address']['geo']['lat']}',
//               ),
//             ),
//             Divider(
//               color: Colors.black,
//             ),
//             Expanded(
//               flex: 2,
//               child: Text(
//                 '${randomData[index]['address']['geo']['lng']}',
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   ),
