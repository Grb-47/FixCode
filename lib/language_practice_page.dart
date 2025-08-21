import 'package:flutter/material.dart';

class LanguagePracticePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String selectedLanguage =
        ModalRoute.of(context)!.settings.arguments as String;

    final List<String> problems = [
      "Problem 1: Hello World",
      "Problem 2: Variables & Data Types",
      "Problem 3: Loops & Conditions",
      "Problem 4: Functions",
      "Problem 5: Arrays / Lists",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Selected Language"),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: problems.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                problems[index],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Practice and improve your coding skills."),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Future: Navigate to Problem Detail Page
              },
            ),
          );
        },
      ),
    );
  }
}