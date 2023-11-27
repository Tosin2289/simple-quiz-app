import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/quiz.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Quiz quiz;
  late List<Results> results;
  Future<void> fetchQuestions() async {
    var res = await http
        .get(Uri.parse("https://opentdb.com/api.php?amount=20&category=21"));
    var decRes = jsonDecode(res.body);
    print(decRes);
    quiz = Quiz.fromJson(decRes);
    results = quiz.results!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Quiz App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: fetchQuestions(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text("Press button to start");
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return const Text("You gats some error");
              } else {
                return questionList();
              }
            default:
              return Container();
          }
        },
      ),
    );
  }

  Widget questionList() {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          elevation: 0,
          child: ExpansionTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  results[index].question.toString(),
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FilterChip(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey.shade100),
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Colors.grey.shade100,
                        onSelected: (b) {},
                        label: Text(
                          results[index].category.toString(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      FilterChip(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey.shade100),
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Colors.grey.shade100,
                        onSelected: (b) {},
                        label: Text(
                          results[index].difficulty.toString(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.grey.shade100,
              child: Text(
                  results[index].type!.startsWith("m") ? "M" : "B".toString()),
            ),
            children: [],
          ),
        );
      },
    );
  }
}

class AnswerWidget extends StatefulWidget {
  const AnswerWidget({super.key});

  @override
  State<AnswerWidget> createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
