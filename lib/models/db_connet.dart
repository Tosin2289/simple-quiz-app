import 'package:http/http.dart' as http;
import 'package:quiz_app/models/question.dart';
import 'dart:convert';

class DbConnect {
  final urls = Uri.parse(
      'http://simplequizapp-415f6-default-rtdb.firebaseio.com/questions.json');
  Future addQuestion(Question question) async {
    http.post(urls,
        body:
            json.encode({'title': question.title, 'options': question.option}));
  }
}
