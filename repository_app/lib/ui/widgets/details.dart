import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Details extends HookWidget {
  final String? repositoryName;
  final String? lastUpdateTime;
  final String? assetImage;
  final String? ownerName;

  const Details({
    Key? key,
    this.repositoryName,
    this.lastUpdateTime,
    this.ownerName,
    this.assetImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (assetImage != null)
          _Image(
            data: assetImage!,
          ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(repositoryName?.toUpperCase() ?? "",
                style: Theme.of(context).textTheme.headline2),
          ],
        ),
        Divider(),
        SizedBox(height: 30),
        Row(
          children: [
            Text(lastUpdateTime ?? "",
                style: Theme.of(context).textTheme.headline3),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Text(ownerName ?? "", style: Theme.of(context).textTheme.headline3),
          ],
        ),
      ],
    );
  }
}

class _Image extends HookWidget {
  final String data;

  const _Image({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: ClipRRect(
        child: SvgPicture.asset(
          data,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(5),
        clipBehavior: Clip.antiAlias,
      ),
    );
  }
}
