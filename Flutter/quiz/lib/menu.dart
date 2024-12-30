import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz/questionnaire.dart';

class Menu extends StatefulWidget {
  final String dataFilePath;
  final String title = 'Flutter Quiz App';
  final String subTitle = 'Teste Seu Conhecimento!';
  const Menu(this.dataFilePath, {super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int totalQuestions = 0;
  int totalSelectedQuestions = 0;
  int totalSelectedTopics = 0;
  int totalQuestionsController = 0;
  int idQuestion = 0;
  int totalScore = 0;
  bool start = false;
  bool allSelected = false;
  bool fillCompleted = false;
  bool loadingComplete = false;
  List<dynamic> questions = [];
  List<dynamic> selectedQuestions = [];
  Set<String> topics = {};
  Map<String, bool> selected = {};

  bool get end => idQuestion < totalSelectedQuestions;

  final int defaultTotalController = 10;
  final bool defaultSelectController = true;
  final bool defaultCacheController = true;

  final TextEditingController totalController = TextEditingController(
    text: '10',
  );

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
            onAll(defaultSelectController);
          },
        );
        totalQuestionsController = defaultTotalController;
        loadingComplete = true;
      },
    );
  }

  void onAll(bool select) {
    setState(() {
      for (var topic in topics) {
        selected[topic] = select;
      }
      allSelected = !select;
      refresh();
    });
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

  void onRestart(bool cache) {
    setState(
      () {
        idQuestion = 0;
        totalScore = 0;
        start = false;
        fillCompleted = false;
        if (cache) {
          for (var topic in topics) {
            if (selected.containsKey(topic)) {
              selected[topic] = (selected[topic] as bool);
            } else {
              selected[topic] = false;
            }
          }
        } else {
          onAll(defaultSelectController);
        }
      },
    );
  }

  void refresh() {
    setState(() {
      selectedQuestions = filterQuestions(questions);
      if (selectedQuestions.isNotEmpty) {
        totalSelectedQuestions = selectedQuestions.length;
      } else {
        totalSelectedQuestions = 0;
      }
    });
  }

  Future<List<dynamic>> loadQuestions() async {
    final String response = await rootBundle.loadString(widget.dataFilePath);
    final data = await json.decode(response);

    return data['Questions'];
  }

  List<dynamic> filterQuestions(listQuestions) {
    Map<String, bool> allSelected = Map.fromEntries(
      selected.entries.where((entry) => entry.value == true),
    );

    totalSelectedTopics = allSelected.length;

    List listSelectedQuestions = listQuestions.where((question) {
      return allSelected.containsKey(question["Question"]["topic"]);
    }).toList();

    listSelectedQuestions = listSelectedQuestions.sublist(
      0,
      (totalQuestionsController > listSelectedQuestions.length)
          ? listSelectedQuestions.length
          : totalQuestionsController,
    );

    return listSelectedQuestions;
  }

  @override
  Widget build(BuildContext context) {
    refresh();
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
              ? Questionnaire(
                  idQuestion: idQuestion,
                  totalScore: totalScore,
                  totalQuestions: totalSelectedQuestions,
                  questions: selectedQuestions,
                  onSelect: onSelect,
                )
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
                        child: Row(
                          children: [
                            Text(
                              "Quantidade de perguntas:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(
                              width: 100,
                            ),
                            Expanded(
                              child: TextField(
                                controller: totalController,
                                onChanged: (value) {
                                  setState(() {
                                    totalQuestionsController =
                                        value.isNotEmpty ? int.parse(value) : 0;
                                    refresh();
                                  });
                                },
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "Total de perguntas.",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 0,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Selecione os tópicos:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () => onAll(allSelected),
                              child: Text('Todos'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: loadingComplete
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
                                          selected[topic] =
                                              value ?? defaultSelectController;
                                          refresh();
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
                            Text(
                                "Perguntas Disponíveis: $totalQuestions/$totalSelectedQuestions",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                )),
                            Text(
                              "Tópicos Disponíveis: ${topics.length}/$totalSelectedTopics",
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
                  onPressed: () => onRestart(defaultCacheController),
                  tooltip: 'restart',
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    Icons.restart_alt,
                    color: Colors.white,
                    size: 40,
                  ),
                )
              : (totalSelectedQuestions > 0) & (totalSelectedTopics > 0)
                  ? FloatingActionButton(
                      onPressed: onNext,
                      tooltip: 'next',
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      ),
                    )
                  : null
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
