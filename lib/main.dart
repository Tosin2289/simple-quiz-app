import 'package:flutter/material.dart';
import 'package:quiz_app/models/db_connet.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/pages/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var db = DbConnect();
  db.addQuestion(
      Question(id: '1', title: "What the capital of Lagos State", option: {
    'Ikeja': true,
    'Ilorin': false,
    'Ibadan': false,
    'Malate': false,
  }));
  db.fetchQuestions();
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
