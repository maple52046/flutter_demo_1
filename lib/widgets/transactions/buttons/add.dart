import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewTxButton extends StatelessWidget {
  // final void Function() callback;
  final VoidCallback callback;
  AddNewTxButton(this.callback);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: callback,
            child: Icon(
              CupertinoIcons.add,
              color: CupertinoColors.white,
            ),
          )
        : IconButton(
            onPressed: callback,
            icon: Icon(
              Icons.add_outlined,
              color: Colors.white,
            ),
          );
  }
}
