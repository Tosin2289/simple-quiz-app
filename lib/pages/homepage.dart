import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/models/db_connet.dart';
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
  var db = DbConnect();
  late Future _question;
  Future<List<Question>> getData() async {
    return db.fetchQuestions();
  }

  @override
  void initState() {
    _question = getData();
    super.initState();
  }

  // List<Question> extractedData = [
  //   Question(id: '1', title: "What the capital of Kwara State", option: {
  //     'Ikeja': false,
  //     'Ilorin': true,
  //     'Ibadan': false,
  //     'Malate': false,
  //   }),
  //   Question(id: '2', title: "What the capital of Lagos State", option: {
  //     'Ikeja': true,
  //     'Ilorin': false,
  //     'Ibadan': false,
  //     'Malate': false,
  //   }),
  // ];
  int index = 0;
  void nextQuestion(int questionlength) {
    if (index == questionlength - 1) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: ((context) => ResultBox(
                onTap: startOver,
                result: score,
                questionlength: questionlength,
              )));
    } else {
      if (ispressed) {
        setState(() {
          index++;
          ispressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
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
    return FutureBuilder(
      future: _question as Future<List<Question>>,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data as List<Question>;
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
                title: const Text("Quiz app"),
              ),
              body: SizedBox(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      QuestionWidget(
                          indexAction: index,
                          question: extractedData[index].title,
                          totalQuestion: extractedData.length),
                      const Divider(
                        color: neutral,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      for (int i = 0;
                          i < extractedData[index].option.length;
                          i++)
                        GestureDetector(
                          onTap: () {
                            checkanswerandupdate(extractedData[index]
                                    .option
                                    .values
                                    .toList()[i] ==
                                true);
                          },
                          child: QuestionCard(
                            option:
                                extractedData[index].option.keys.toList()[i],
                            color: ispressed
                                ? extractedData[index]
                                            .option
                                            .values
                                            .toList()[i] ==
                                        true
                                    ? correct
                                    : incorrect
                                : neutral,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: GestureDetector(
                onTap: () => nextQuestion(extractedData.length),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: NextButton(),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const Center(
          child: Text('No Data'),
        );
      },
    );
  }
}
