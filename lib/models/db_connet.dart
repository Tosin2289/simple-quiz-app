import 'package:http/http.dart' as http;
import 'package:quiz_app/models/question.dart';
import 'dart:convert';

class DbConnect {
  var url = Uri.parse(
      'https://simplequizapp-415f6-default-rtdb.firebaseio.com/questions.json');
  Future addQuestion(Question question) async {
    http.post(url,
        body:
            jsonEncode({'title': question.title, 'options': question.option}));
  }

  Future<void> fetchQuestions() async {
    http.get(url).then((response) {
      var data = jsonDecode(response.body);
      print(data);
    });
  }
}
