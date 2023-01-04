import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/widgets/next_button.dart';

import 'package:quiz_app/widgets/question_card.dart';
import 'package:quiz_app/widgets/question_widget.dart';
import 'package:quiz_app/widgets/result_box.dart';

import '../models/question.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Question> questions = [
    Question(id: '1', title: "What the capital of Kwara State", option: {
      'Ikeja': false,
      'Ilorin': true,
      'Ibadan': false,
      'Malate': false,
    }),
    Question(id: '1', title: "What the capital of Lagos State", option: {
      'Ikeja': true,
      'Ilorin': false,
      'Ibadan': false,
      'Malate': false,
    }),
  ];
  int index = 0;
  void nextQuestion() {
    if (index == questions.length - 1) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: ((context) => ResultBox(
                onTap: startOver,
                result: score,
                questionlength: questions.length,
              )));
    } else {
      if (ispressed) {
        setState(() {
          index++;
          ispressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please select an option'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20),
        ));
      }
    }
  }

  bool ispressed = false;
  bool isAlreadySelected = false;
  void checkanswerandupdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        ispressed = true;
        isAlreadySelected = true;
      });
    }
  }

  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      ispressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  int score = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.all(18),
            child: Text(
              'score : $score',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: background,
        title: Text("Quiz app"),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            QuestionWidget(
                indexAction: index,
                question: questions[index].title,
                totalQuestion: questions.length),
            Divider(
              color: neutral,
            ),
            SizedBox(
              height: 25,
            ),
            for (int i = 0; i < questions[index].option.length; i++)
              GestureDetector(
                onTap: () {
                  checkanswerandupdate(
                      questions[index].option.values.toList()[i] == true);
                },
                child: QuestionCard(
                  option: questions[index].option.keys.toList()[i],
                  color: ispressed
                      ? questions[index].option.values.toList()[i] == true
                          ? correct
                          : incorrect
                      : neutral,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: NextButton(
          nextQuestion: nextQuestion,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
