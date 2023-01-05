import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

class QuestionWidget extends StatelessWidget {
  QuestionWidget(
      {Key? key,
      required this.indexAction,
      required this.question,
      required this.totalQuestion})
      : super(key: key);

  final String question;
  final int indexAction;
  final int totalQuestion;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Question ${indexAction + 1}/$totalQuestion:$question',
        style: const TextStyle(fontSize: 24, color: neutral),
      ),
    );
  }
}
