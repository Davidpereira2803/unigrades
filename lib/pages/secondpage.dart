import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final TextEditingController myControllerSelectedCourse = TextEditingController();
  List<dynamic> courseData= [];

  void clearTextFields(){
    myControllerSelectedCourse.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(230, 175, 175, 175),
        primaryColor: const Color.fromARGB(200, 180, 37, 37),
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(200, 180, 37, 37)),
        useMaterial3: true,
       ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(220, 180, 37, 37),
          title: const Text('Grade Dashboard'),
        ),
        body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: myControllerSelectedCourse,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter the desired Course',
              ),
            ),
          ),
        Expanded(
          child: ListView.builder(
            itemCount: courseData.length,
            itemBuilder: (context, index) {
              String course = courseData[index]['course'];
              String name = courseData[index]['name'];
              String grade = courseData[index]['grade'];
              return CustomListItem(
                name: name,
                grade: grade,
                course: course,
              );
            },
          ),
        ),
        ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: (){
                Navigator.pop(context);
                },
                tooltip: 'Go to Home Page',
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(Icons.home)
              ),
              FloatingActionButton(
                onPressed: (){
                  loadCourseData(myControllerSelectedCourse.text);
                },
                tooltip: 'Get Course',
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(Icons.query_stats),
                ),
            ]
          ),
      ),
    );
  }

  void loadCourseData(String courseName) async {
    Directory? externalDir = await getExternalStorageDirectory();
    String filePath="";
    try {
      if(externalDir !=null){
      String externalPath = externalDir.path;
      filePath = '$externalPath/$courseName.json';
      }
      String jsonData = File(filePath).readAsStringSync();

      List<dynamic> data = json.decode(jsonData);
    
      setState(() {
        courseData = data;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error loading data: $e');
      }
    }
    clearTextFields();
  }

  @override
  void dispose() {
    myControllerSelectedCourse.dispose();
    super.dispose();
  }
}


class CustomListItem extends StatelessWidget {
  final String name;
  final String grade;
  final String course;

  const CustomListItem({super.key, required this.name, required this.grade, required this.course});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Course: $course'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: $name'),
          Text('Grade: $grade'),
        ],
      ),
    );
  }
}