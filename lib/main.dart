import 'package:flutter/cupertino.dart';
import './quiz.dart';
import './result.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

const questions = const [
  {
    'question': 'What is your favorite color ?',
    'answers': [
      {'label': 'Red', 'score': 2},
      {'label': 'Yellow', 'score': 3},
      {'label': 'Blue', 'score': 8},
      {'label': 'Green', 'score': 6},
      {'label': 'Black', 'score': 9},
    ],
  },
  {
    'question': 'Who is your favorite girl ?',
    'answers': [
      {'label': 'Dorrit', 'score': 5},
      {'label': 'Bear', 'score': 9},
    ],
  }
];

class _HomePageState extends State<HomePage> {
  var _questionId = 0;
  var _totalScore = 0;

  void answerQestion(int score) {
    setState(() {
      // questionId = (questionId + 1) % 2;
      _questionId += 1;
      _totalScore += score;
    });
  }

  void resetQuiz() {
    setState(() {
      _questionId = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('My Demo App')),
      child: _questionId < questions.length
          ? Quiz(
              questions: questions,
              questionId: _questionId,
              answerHandler: answerQestion,
            )
          : Result(
              score: _totalScore,
              resetCallback: resetQuiz,
            ),
    );
  }
}
