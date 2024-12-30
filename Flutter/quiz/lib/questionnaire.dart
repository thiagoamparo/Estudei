import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz/clue.dart';
import 'package:quiz/question.dart';
import 'package:quiz/resolution.dart';
import 'package:quiz/response.dart';

class Questionnaire extends StatefulWidget {
  final String title = 'Flutter Quiz App';
  final String subTitle = 'Teste Seu Conhecimento!';

  const Questionnaire({super.key});

  @override
  State<Questionnaire> createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  int totalQuestions = 0;
  int idQuestion = 0;
  int totalScore = 0;
  bool start = false;

  void onSelect(int score) {
    setState(
      () {
        idQuestion++;
        totalScore += score;
      },
    );
  }

  void onStart() {
    setState(
      () {
        start = true;
      },
    );
  }

  void onRestart() {
    setState(
      () {
        idQuestion = 0;
        totalScore = 0;
        start = false;
      },
    );
  }

  bool get end => idQuestion < totalQuestions;

  Future<List<Question>> loadQuestions() async {
    final String response =
        await rootBundle.loadString('assets/json/questions.json');
    final data = await json.decode(response);

    return (data['Questions'] as List)
        .map((question) => createQuestion(question))
        .toList();
  }

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      body: start
          ? FutureBuilder<List<Question>>(
              future: loadQuestions(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Sem perguntas disponíveis.'));
                } else {
                  totalQuestions = (snapshot.data as List).length;

                  return end
                      ? (snapshot.data as List)[idQuestion]
                      : Resolution(totalScore);
                }
              },
            )
          : Center(
              child: Text(
                widget.subTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
      floatingActionButton: start
          ? FloatingActionButton(
              onPressed: onRestart,
              tooltip: 'restart',
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                Icons.restart_alt,
                color: Colors.white,
                size: 40,
              ),
            )
          : FloatingActionButton(
              onPressed: onStart,
              tooltip: 'start',
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 40,
              ),
            ),
    );
  }
}
