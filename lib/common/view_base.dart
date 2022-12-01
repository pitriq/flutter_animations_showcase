import 'package:flutter/material.dart';

class ViewBase extends StatelessWidget {
  final String? title;
  final Widget? child;

  const ViewBase({super.key, this.title, this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title != null ? Text(title!) : null),
      body: SafeArea(
        child: Center(child: child),
      ),
    );
  }
}
