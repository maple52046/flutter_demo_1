import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final VoidCallback onPressed;

  Answer(this.answerText, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      child:
          CupertinoButton.filled(child: Text(answerText), onPressed: onPressed),
    );
  }
}
