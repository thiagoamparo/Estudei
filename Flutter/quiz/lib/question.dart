import 'package:flutter/material.dart';
import 'package:quiz/clue.dart';

import './response.dart';

class Question extends StatefulWidget {
  final String statement;
  final String topic;
  final List<Clue> clues;
  final List<Response> answers;

  const Question({
    required this.statement,
    required this.topic,
    required this.clues,
    required this.answers,
    super.key,
  });

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  int idClue = 0;
  bool clue = false;

  void toggleClues() {
    setState(
      () {
        clue = !clue;
        nextClue();
      },
    );
  }

  void nextClue() {
    if (clue) {
      idClue++;
      idClue = idClue % widget.clues.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                    child: Icon(
                      Icons.question_answer_outlined,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 8, 0, 8),
                    child: Text(
                      widget.topic,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 8),
                    child: Text(
                      widget.statement,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  if (clue) (widget.clues)[idClue],
                  IconButton(
                    onPressed: toggleClues,
                    icon: clue
                        ? Icon(Icons.lightbulb)
                        : Icon(Icons.lightbulb_outlined),
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ],
              ),
            ],
          ),
        ),
        ...widget.answers..shuffle(),
      ],
    );
  }
}
