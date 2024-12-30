import 'package:flutter/material.dart';
import 'package:quiz/clue.dart';
import 'package:quiz/question.dart';
import 'package:quiz/resolution.dart';
import 'package:quiz/response.dart';

class Questionnaire extends StatelessWidget {
  final int idQuestion;
  final int totalScore;
  final int totalQuestions;
  final List<dynamic> questions;
  final void Function(int score) onSelect;

  const Questionnaire({
    required this.idQuestion,
    required this.totalScore,
    required this.totalQuestions,
    required this.questions,
    required this.onSelect,
    super.key,
  });

  Question createQuestion(Map<String, dynamic> question) {
    return Question(
      statement: question['Question']['statement'].toString(),
      topic: question['Question']['topic'].toString(),
      clues: (question['Question']['clues'] as List).map(
        (clue) {
          return Clue(
            statement: clue['statement'],
          );
        },
      ).toList(),
      answers: (question['Question']['answers'] as List).map(
        (response) {
          return Response(
            statement: response['statement'],
            score: response['score'] as int,
            onSelect: () => onSelect(response['score'] as int),
          );
        },
      ).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return idQuestion < questions.length
        ? createQuestion(questions[idQuestion])
        : Resolution(totalScore, totalQuestions);
  }
}
