import 'package:flutter/material.dart';
import 'package:tic_tac_toe/square.dart';
import 'package:tic_tac_toe/vscomputer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final List _post = [
    'VS COMPUTER',
    'VS PERSON',
  ];

  final List<String> routes = [
    '/VsComputer',
    '/VsPerson',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Center(
          child: Text(
            "Tic Tac Toe",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
        backgroundColor: Colors.grey[800],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _post.length,
          itemBuilder: (context, index) {
            return Square(
              child: _post[index],
              onTap: () {
                Navigator.pushNamed(context, routes[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
