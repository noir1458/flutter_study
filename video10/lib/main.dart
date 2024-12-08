import 'package:flutter/material.dart';
import 'package:untitled/editpage.dart';
import 'package:untitled/score.dart';
import 'package:untitled/scorepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Scores(),
      builder: (context,child) => MaterialApp(
        title: 'My App',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: Scorepage(),
      ),
    );
  }
}
