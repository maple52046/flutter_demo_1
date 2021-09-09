import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class Result extends StatelessWidget {
  final int score;
  final VoidCallback resetCallback;

  Result({
    required this.score,
    required this.resetCallback,
  });

  String get resultPhrase {
    var message = '勉勉強強';
    if (score > 10) {
      message = '太棒惹, 你拿到 $score 分!';
    }
    return message;
  }

  List<Widget> get showContent => [
        Container(
          width: double.infinity,
          margin: EdgeInsets.all(10),
          child: Center(
            child: Text(
              resultPhrase,
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
        CupertinoButton(
          child: Text('Reset Quiz'),
          onPressed: resetCallback,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: showContent,
    );
  }
}
