import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox(
      {Key? key,
      required this.result,
      required this.questionlength,
      required this.onTap})
      : super(key: key);
  final int result;
  final int questionlength;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: background,
      content: Padding(
        padding: EdgeInsets.all(70),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Result',
              style: TextStyle(
                  color: neutral, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            CircleAvatar(
              backgroundColor: result == questionlength / 2
                  ? Colors.yellow
                  : result < questionlength / 2
                      ? incorrect
                      : correct,
              radius: 50,
              child: Text(
                '$result/$questionlength',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              result == questionlength / 2
                  ? 'Almost There'
                  : result < questionlength / 2
                      ? 'Try Again'
                      : 'Great!',
              style: const TextStyle(color: neutral),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: onTap,
              child:const Text(
                "Start over",
                style: TextStyle(
                  fontSize: 23,
                  color: neutral,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
