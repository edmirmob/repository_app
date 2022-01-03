import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static Future<void> initialize() async {
    return dotenv.load();
  }

  static String get baseUrl => 'https://api.github.com/search';

  static String get androidConfig => "$baseUrl/app-version/android";

  static String get iosConfig => "$baseUrl/app-version/ios";

  static String get versionConfig =>
      Platform.isAndroid ? androidConfig : iosConfig;
}
