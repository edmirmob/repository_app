import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoIndicator extends StatelessWidget {
  final String svgAsset;
  final String title;
  final Widget? content;
  final String? actionText;
  final Function()? onActionPressed;
  final TextAlign textAlign;

  const InfoIndicator({
    Key? key,
    required this.svgAsset,
    required this.title,
    this.content,
    this.onActionPressed,
    this.actionText,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(svgAsset),
        SizedBox(height: 42),
        Text(title,
            style: Theme.of(context).textTheme.headline1, textAlign: textAlign),
        SizedBox(height: 18),
        if (content != null) content!,
        if (actionText != null) ...[
          SizedBox(height: 48),
          ElevatedButton(
            child: Text(actionText!.toUpperCase()),
            onPressed: () => onActionPressed?.call(),
          ),
        ],
      ],
    );
  }
}
