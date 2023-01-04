import 'package:flutter/material.dart';
import 'package:quiz_app/models/db_connet.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/pages/homepage.dart';

void main() async {
  var db = DbConnect();
  db.addQuestion(Question(
      id: '3',
      title: 'Most watched sport in the world',
      option: {
        'Basketball': false,
        'Volleyball': false,
        'Football': true,
        'Cricket': false
      }));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
