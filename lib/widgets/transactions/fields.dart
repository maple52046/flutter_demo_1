import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NewTxTextField extends StatelessWidget {
  final String placeholder;
  final TextEditingController controller;
  final TextInputType keyboardType;

  NewTxTextField(this.placeholder, this.controller, this.keyboardType);

  @override
  Widget build(BuildContext context) {
    final _androidField = TextField(
      style: const TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: TextStyle(
          color: Colors.grey[800],
        ),
      ),
      controller: controller,
      keyboardType: keyboardType,
    );

    final _iosField = CupertinoTextField.borderless(
      style: const TextStyle(
        color: CupertinoColors.black,
      ),
      placeholder: placeholder,
      placeholderStyle: const TextStyle(
        color: CupertinoColors.systemGrey,
      ),
      controller: controller,
      keyboardType: keyboardType,
    );

    return Platform.isIOS ? _iosField : _androidField;
  }
}
