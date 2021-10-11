import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _AndroidButton extends StatelessWidget {
  final bool isLandscaped;
  final VoidCallback callback;

  _AndroidButton(this.isLandscaped, this.callback);

  @override
  Widget build(BuildContext context) {
    const icon = Icon(Icons.delete_outline_sharp);

    return isLandscaped
        ? ElevatedButton(
            onPressed: callback,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [icon, Text('Delete')],
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
            ),
          )
        : IconButton(
            color: Colors.red,
            icon: icon,
            onPressed: callback,
          );
  }
}

class _IOSButton extends StatelessWidget {
  final bool isLandscaped;
  final VoidCallback callback;

  _IOSButton(this.isLandscaped, this.callback);

  @override
  Widget build(BuildContext context) {
    const icon = Icon(Icons.delete_outline_sharp);

    final child = isLandscaped
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [icon, Text('Delete')],
          )
        : icon;

    return CupertinoButton(child: child, onPressed: callback);
  }
}

class DeleteTxButton extends StatelessWidget {
  // final double parentWidth;
  // DeleteTxButton(this.parentWidth);

  // final bool isLandscaped = MediaQuery.of(context).size.width > 500;
  final bool isLandscaped;
  final VoidCallback callback;

  DeleteTxButton(this.isLandscaped, this.callback);

  @override
  Widget build(BuildContext context) {
    final isLandscaped = MediaQuery.of(context).size.width > 500;

    return Platform.isIOS
        ? _IOSButton(isLandscaped, callback)
        : _AndroidButton(isLandscaped, callback);
  }
}
