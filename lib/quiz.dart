import 'package:flutter/cupertino.dart';
import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionId;
  final Function(int) answerHandler;

  Quiz({
    required this.questions,
    required this.questionId,
    required this.answerHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Question((questions[questionId]['question'] as String)),
        ...(questions[questionId]['answers'] as List<Map>).map((answer) =>
            Answer(answer['label'], () => answerHandler(answer['score']))),
      ],
    );
  }
}
