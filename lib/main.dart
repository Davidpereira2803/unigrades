// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'secondpage.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unversity Grades',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 128, 128, 128),
        primaryColor: const Color.fromARGB(255, 190, 110, 70),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 196, 118, 73)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'University Grades'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 190, 110, 70),
        title: Text(widget.title),
      ),
      body:
        const MyCustomForm(),
      );
  }
}


class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {

  final TextEditingController myControllerName = TextEditingController();
  final TextEditingController myControllerGrade = TextEditingController();
  final TextEditingController myControllerCourse = TextEditingController();

  String result(){
    return '${myControllerCourse.text.toUpperCase()}: ${myControllerName.text}: ${myControllerGrade.text}';
  }


void updateJsonFile(String filePath, Map<String, dynamic> newData) {
  final file = File(filePath);

  List<dynamic> existingData = [];
  if (file.existsSync()) {
    final jsonString = file.readAsStringSync();
    if (jsonString.isNotEmpty) {
      existingData = json.decode(jsonString);
    }
  }
  existingData.add(newData);

  final updatedJsonString = json.encode(existingData);
  file.writeAsStringSync(updatedJsonString);
}

void main() async {

  Directory? externalDir = await getExternalStorageDirectory();
  String filePath="";

  if (externalDir != null) {
    String externalPath = externalDir.path;
    filePath = '$externalPath/${myControllerCourse.text.toLowerCase()}.json';
  } else {}

  Map<String, dynamic> newData = {
    'course': myControllerCourse.text.toUpperCase(),
    'name': myControllerName.text,
    'grade': myControllerGrade.text,
  };

  updateJsonFile(filePath, newData);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
      content: Text(filePath),
        );
      },
    );
  }

  @override
  void dispose(){
    myControllerCourse.dispose();
    myControllerName.dispose();
    myControllerGrade.dispose();
    super.dispose();
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            TextField(
              controller: myControllerCourse,
              decoration: const InputDecoration(
                labelText: 'Course',
                border: OutlineInputBorder(),
                hintText: 'Enter Course',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: myControllerName,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
                hintText: 'Enter Name',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: myControllerGrade,
                decoration: const InputDecoration(
                  labelText: 'Grade',
                  border: OutlineInputBorder(),
                  hintText: 'Enter Grade',
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: main,
            tooltip: 'Add Exam',
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed:(){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecondPage()),
              );
            },
            tooltip: 'Go to Dashboard',
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.dashboard),
          ),
        ],
      ),
    );
  }


}
