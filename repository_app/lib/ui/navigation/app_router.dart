import 'package:flutter/material.dart';
import 'package:repository/core/data/repositories.dart';
import 'package:repository/ui/navigation/app_routes.dart';
import 'package:repository/ui/screens/error_screen.dart';
import 'package:repository/ui/screens/repository_details_screen.dart';
import 'package:repository/ui/screens/repository_screen.dart';
import 'package:repository/ui/screens/splash_screen.dart';
import 'package:repository/ui/screens/unknown_screen.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SplashScreen(),
        );
      case AppRoutes.error:
        return MaterialPageRoute(
          fullscreenDialog: true,
          settings: settings,
          builder: (_) => ErrorScreen(onActionPressed: args?.onPressed),
        );

      case AppRoutes.repositories:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => RepositoryScreen(),
        );
      case AppRoutes.repositoryDetails:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => RepositoryDetailsScreen(id: args.repositoryId),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => UnknownScreen(pageName: settings.name ?? 'Unknown'),
        );
    }
  }
}

extension _ArgsExtensions on dynamic {
  int get repositoryId {
    if (this is int) {
      return this;
    } else if (this is Item) {
      return (this as Item).id as int;
    }
    throw StateError('This is not a repository item');
  }

  Function() get onPressed => this;
}
