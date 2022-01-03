import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repository/providers/splash_providers.dart';
import 'package:repository/providers/state/status.dart';
import 'package:repository/ui/navigation/app_routes.dart';
import 'package:repository/ui/widgets/animated_logo.dart';

void _goToError(BuildContext context) {
  Navigator.of(context).pushReplacementNamed(AppRoutes.error);
}

void _goToHome(BuildContext context) {
  Navigator.of(context).pushReplacementNamed(AppRoutes.repositories);
}

class SplashScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final splashStatus = useProvider(splashStatusProvider).state;

    useEffect(() {
      Future.microtask(() => context.read(splashViewController).splash());
      return null;
    }, [splashViewController]);

    useEffect(() {
      Future.microtask(() {
        splashStatus.when(
          fulfilled: () => _goToHome(context),
          rejected: () => _goToError(context),
        );
      });
      return null;
    }, [splashStatus]);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: AnimatedLogo()),
    );
  }
}
