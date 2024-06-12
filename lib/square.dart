import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  const Square({
    super.key,
    required this.child,
    this.onTap,
  });
  final String child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Color.fromARGB(255, 49, 48, 48),
          height: 80,
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Text(
              child,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
