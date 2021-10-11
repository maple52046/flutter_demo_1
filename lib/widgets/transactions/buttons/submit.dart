import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubmitNewTxButton extends StatelessWidget {
  final VoidCallback submit;

  SubmitNewTxButton(this.submit);

  Widget getButtonLabel(IconData icon, Color color) {
    double fsize = 14.0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: fsize),
        Text(
          'Add',
          style: TextStyle(
            fontSize: fsize,
            color: color,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton.filled(
            child: getButtonLabel(CupertinoIcons.add, CupertinoColors.white),
            onPressed: submit,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 1),
          )
        : ElevatedButton(
            child: getButtonLabel(Icons.add, Colors.white),
            onPressed: submit,
          );
  }
}
