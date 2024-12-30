import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz/clue.dart';
import 'package:quiz/question.dart';
import 'package:quiz/questionnaire.dart';
import 'package:quiz/response.dart';

class Menu extends StatefulWidget {
  final String title = 'Questionário Geral';
  final String subTitle = 'Teste Seu Conhecimento!';
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int totalQuestions = 0;
  int idQuestion = 0;
  int totalScore = 0;
  bool start = false;
  bool fillCompleted = false;
  bool loadingCompleted = false;
  List<dynamic> questions = [];
  Set<String> topics = {};
  Map<String, bool> selected = {};

  @override
  void initState() {
    super.initState();
    loadQuestions().then(
      (loadedQuestions) {
        setState(
          () {
            questions = loadedQuestions;
            totalQuestions = loadedQuestions.length;
            topics = loadedQuestions
                .map((question) => (question['Question']['topic'] as String))
                .toList()
                .toSet();
            for (var topico in topics) {
              selected[topico] = false;
            }
          },
        );
        loadingCompleted = true;
      },
    );
  }

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

  void onNext() {
    setState(
      () {
        fillCompleted = true;
      },
    );
  }

  void onRestart() {
    setState(
      () {
        idQuestion = 0;
        totalScore = 0;
        start = false;
        fillCompleted = false;
      },
    );
  }

  final TextEditingController total = TextEditingController();

  Future<List<dynamic>> loadQuestions() async {
    // await Future.delayed(Duration(seconds: 2));
    final String response =
        await rootBundle.loadString('assets/json/questions.json');
    final data = await json.decode(response);

    return data['Questions'];
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
          ? fillCompleted
              ? Questionnaire()
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        child: Text(
                          "Quantidade de perguntas:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      TextField(
                        controller: total,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Digite a quantidade de perguntas",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 10,
                        ),
                        child: Text(
                          "Selecione os tópicos:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      Expanded(
                        child: loadingCompleted
                            ? ListView.builder(
                                itemCount: topics.length,
                                itemBuilder: (context, index) {
                                  final topic = topics.toList()[index];
                                  return CheckboxListTile(
                                    title: Text(
                                      topic,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    value: selected[topic],
                                    onChanged: (bool? value) {
                                      setState(
                                        () {
                                          selected[topic] = value ?? false;
                                        },
                                      );
                                    },
                                  );
                                },
                              )
                            : Center(child: CircularProgressIndicator()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Perguntas Disponíveis: $totalQuestions",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                )),
                            Text(
                              "Tópicos Disponíveis: $totalQuestions",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
          ? fillCompleted
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
                  onPressed: onNext,
                  tooltip: 'start',
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    Icons.play_arrow,
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
