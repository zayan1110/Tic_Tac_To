import 'package:flutter/material.dart';
import 'package:tic_tac_toe/homePage.dart';
import 'package:tic_tac_toe/vsComputer.dart';
import 'package:tic_tac_toe/vsPerson.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/VsComputer': (context) => VsComputer(),
        '/VsPerson': (context) =>
            VsPerson(), // assuming VsComputer is a StatelessWidget
      },
    );
  }
}
