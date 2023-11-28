import 'package:flutter/material.dart';
import 'package:quiz_app/pages/homepage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController questionController = TextEditingController();
  String initialcategory = 'Any Category';
  List categories = [
    'Any Category',
    'General Knowledge',
    'Entertainment:Books',
    'Entertainment:Film',
    'Entertainment:Music',
    'Entertainment:Musicals & Theatres',
    'Entertainment:Television',
    'Entertainment:Video Games',
    'Entertainment: Board Games',
    'Science & Nature',
    'Science: Computers',
    'Science: Mathematics',
    'Mythology',
    'Sports',
    'Geography',
    'History',
    'Politics',
    'Art',
    'Celebrities',
    'Animals',
    'Vehicles',
    'Science: Gadgets',
    'Entertainment:Comics',
    'Entertainment:Japanese Anime & Manga',
    'Entertainment:Cartoon & Animations',
  ];
  String initialdifficulties = 'Any Difficulty';
  List difficulies = [
    'Any Difficulty',
    'Easy',
    'Medium',
    'Hard',
  ];
  String initialtype = 'Any Type';
  List types = [
    'Any Type',
    'Multiple Choice',
    'True / False',
  ];
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Number of Questions :",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: questionController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Select Category :",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField(
                value: initialcategory,
                items: categories.map((value) {
                  return DropdownMenuItem(
                      value: value.toString(),
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 18),
                      ));
                }).toList(),
                onChanged: (String? v) {
                  setState(() {
                    initialcategory = v!;
                  });
                }),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return HomePage(amount: questionController.text);
              },
            ));
          },
          child: const Text(
            "Continue",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
