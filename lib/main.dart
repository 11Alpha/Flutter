import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List _data = [];

  Future<void> fetchData() async {
    var url =
        'http://localhost/empp/show_record_in_json.php'; // Replace with your PHP file URL
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        _data = jsonDecode(response.body);
      });
      print(_data);
    } else {
      // Error occurred while fetching data
      throw Exception(
          'HTTP request failed, statusCode: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My App'),
        ),
        body: _data.isNotEmpty
            ? ListView.builder(
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('ID: ${_data[index]['id']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ${_data[index]['name']}'),
                        Text('Designation: ${_data[index]['designation']}'),
                        Text('Salary: ${_data[index]['salary']}'),
                      ],
                    ),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
