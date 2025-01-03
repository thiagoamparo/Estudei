import 'package:flutter/material.dart';

class Resolution extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const Resolution(this.score, this.totalQuestions, {super.key});

  String get categorizeScore {
    double percentageScore = (score / (totalQuestions * 10)) * 100;

    if (percentageScore >= 90) {
      return 'Jedi (Mestre da Força)';
    } else if (percentageScore >= 70) {
      return 'Super Saiyajin (Poder Infinito)';
    } else if (percentageScore >= 50) {
      return 'Vingador (Herói Cauteloso)';
    } else if (percentageScore >= 30) {
      return 'Explorador Espacial (Aventuras Intergalácticas)';
    } else {
      return 'Iniciado (Missão em Andamento)';
    }
  }

  Icon get categoryIcon {
    double percentageScore = (score / (totalQuestions * 10)) * 100;
    if (percentageScore >= 90) {
      return Icon(Icons.star, size: 50, color: Colors.blue);
    } else if (percentageScore >= 70) {
      return Icon(Icons.flash_on, size: 50, color: Colors.yellow);
    } else if (percentageScore >= 50) {
      return Icon(Icons.shield, size: 50, color: Colors.red);
    } else if (percentageScore >= 30) {
      return Icon(Icons.explore, size: 50, color: Colors.green);
    } else {
      return Icon(Icons.access_time, size: 50, color: Colors.orange);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Teste Finalizado',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Parabéns!\nSeu status é:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        categoryIcon,
                        SizedBox(height: 20),
                        Text(
                          categorizeScore,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
