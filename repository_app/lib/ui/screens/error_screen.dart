import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:repository/ui/navigation/app_routes.dart';
import 'package:repository/ui/widgets/info_indicator.dart';
import 'package:repository/util/Assets.dart';

void _goBackToSplash(BuildContext context) {
  Navigator.of(context).pushNamedAndRemoveUntil(
    AppRoutes.splash,
    (route) => false,
  );
}

class ErrorScreen extends HookWidget {
  final Function()? onActionPressed;

  const ErrorScreen({
    Key? key,
    this.onActionPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final handleActionPressed = useMemoized(() {
      return () => onActionPressed?.call() ?? _goBackToSplash(context);
    }, [onActionPressed, context]);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: InfoIndicator(
          svgAsset: ImageAssets.maintenance,
          title: "An error has occurred",
          content: Text(
            "We apologize, but an error occurred. Our team is working to fix the problem. Please try again later.",
          ),
          actionText: "OK",
          onActionPressed: handleActionPressed,
        ),
      ),
    );
  }
}
