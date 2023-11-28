// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import '../models/quiz.dart';

class HomePage extends StatefulWidget {
  final String amount;
  const HomePage({
    Key? key,
    required this.amount,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Quiz quiz;
  late List<Results> results;
  Future<void> fetchQuestions() async {
    var res = await http.get(Uri.parse(
        "https://opentdb.com/api.php?amount=${widget.amount}&category=21"));
    var decRes = jsonDecode(res.body);

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
      body: RefreshIndicator(
        onRefresh: fetchQuestions,
        child: FutureBuilder(
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
                  return errorData();
                } else {
                  return questionList();
                }
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }

  Widget errorData() {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/404.json"),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    fetchQuestions();
                    setState(() {});
                  },
                  child: const Text("Try again"),
                )
              ],
            ),
          ),
        ));
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
            children: results[index].allAnswers!.map((m) {
              return AnswerWidget(results: results, index: index, m: m);
            }).toList(),
          ),
        );
      },
    );
  }
}

class AnswerWidget extends StatefulWidget {
  final List<Results> results;
  final int index;
  final String m;
  const AnswerWidget({
    Key? key,
    required this.results,
    required this.index,
    required this.m,
  }) : super(key: key);

  @override
  State<AnswerWidget> createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  Color color = Colors.black;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          if (widget.m == widget.results[widget.index].correctAnswer) {
            color = Colors.green;
          } else {
            color = Colors.red;
          }
        });
      },
      title: Text(
        widget.m,
        textAlign: TextAlign.center,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
