import 'package:flutter/material.dart';

class Response extends StatelessWidget {
  final String statement;
  final int score;
  final void Function() onSelect;

  const Response(
      {required this.statement,
      required this.score,
      required this.onSelect,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
        ),
        onPressed: onSelect,
        child: Text(
          statement,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
