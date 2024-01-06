import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String joke = "Press the button to get a joke";

  Future<void> fetchJoke() async {
    final response = await http.get(Uri.parse("https://v2.jokeapi.dev/joke/Any"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        joke = data['setup'] ?? "No joke available";
      });
    } else {
      setState(() {
        joke = "Failed to fetch joke";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Joke App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                joke,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  fetchJoke();
                },
                child: Text('Get Joke'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}