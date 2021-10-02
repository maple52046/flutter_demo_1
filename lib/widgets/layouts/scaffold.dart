import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

double _getHeight(BuildContext ctx, Size bsize) {
  final mediaQuery = MediaQuery.of(ctx);
  double height =
      mediaQuery.size.height - bsize.height - mediaQuery.padding.top;
  return height;
}

class _AndroidScaffold extends StatelessWidget {
  final AppBar appBar;
  final Widget body;

  _AndroidScaffold(this.appBar, this.body);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        height: _getHeight(
          context,
          appBar.preferredSize,
        ),
        child: body,
      ),
    );
  }
}

class _IOSScaffold extends StatelessWidget {
  final CupertinoNavigationBar appBar;
  final Widget body;

  _IOSScaffold(this.appBar, this.body);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: appBar,
      child: Container(
        height: _getHeight(
          context,
          appBar.preferredSize,
        ),
        child: body,
      ),
    );
  }
}

class MyAppScaffold extends StatelessWidget {
  final Widget title;
  final Widget trail;
  final Widget body;

  MyAppScaffold({required this.title, required this.trail, required this.body});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _IOSScaffold(
            CupertinoNavigationBar(
              backgroundColor: Colors.indigo[800],
              middle: title,
              trailing: trail,
            ),
            SingleChildScrollView(child: body),
          )
        : _AndroidScaffold(
            AppBar(
              title: title,
              actions: [trail],
            ),
            SingleChildScrollView(child: body),
          );
  }
}
