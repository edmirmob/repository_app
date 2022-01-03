
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repository/environment.dart';
import 'package:repository/ui/navigation/app.dart';

void main() async {
  await Environment.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(ProviderScope(child: RepositoryApp()));

}

class RepositoryApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return App();
  }
}