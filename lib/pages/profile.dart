import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
          title: const Text('Profile'),
          centerTitle: true,
          leading: IconButton(
                onPressed: (){
                Navigator.pop(context);
                },
                icon: const Icon(Icons.home),
                tooltip: 'Go to Home Page',
          ),
        ),
        body: const Center(
          child: Text('Hello, Flutter!'),
        ),
      ),
    );
  }
}
