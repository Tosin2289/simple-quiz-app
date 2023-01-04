import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

class NextButton extends StatelessWidget {
  const NextButton({Key? key, required this.nextQuestion}) : super(key: key);
  final VoidCallback nextQuestion;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: nextQuestion,
      child: Container(
        decoration: BoxDecoration(
            color: neutral, borderRadius: BorderRadius.circular(10)),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          'Next Question',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
