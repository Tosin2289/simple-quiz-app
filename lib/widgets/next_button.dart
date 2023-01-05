import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: neutral, borderRadius: BorderRadius.circular(10)),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: const Text(
        'Next Question',
        style: TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
      ),
    );
  }
}
