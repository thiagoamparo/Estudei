import 'package:flutter/material.dart';

class Clue extends StatelessWidget {
  final String statement;

  const Clue({required this.statement, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        statement,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
