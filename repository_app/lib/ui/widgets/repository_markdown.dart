import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:repository/ui/repository_theme.dart';

class RepositoryMarkdown extends StatelessWidget {
  final String content;
  final double blockSpacing;

  const RepositoryMarkdown({
    Key? key,
    required this.content,
    this.blockSpacing = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: content,
      onTapLink: (text, link, title) => launch(link!),
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
        blockSpacing: blockSpacing,
        p: Theme.of(context)
            .textTheme
            .headline3
            ?.copyWith(fontSize: 16, height: 1.4),
        blockquoteDecoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              left: BorderSide(color: RepositoryTheme.colorGrey2, width: 3)),
        ),
        blockquotePadding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      ),
    );
  }
}
