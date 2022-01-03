import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:repository/ui/widgets/repository_markdown.dart';

class DescriptionBody extends HookWidget {
  final String content;

  const DescriptionBody({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryMarkdown(content: content);
  }
}
