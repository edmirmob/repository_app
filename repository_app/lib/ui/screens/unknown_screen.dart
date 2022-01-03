import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UnknownScreen extends HookWidget {
  final String pageName;

  const UnknownScreen({
    Key? key,
    required this.pageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Page $pageName not found'),
      ),
    );
  }
}
