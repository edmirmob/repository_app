import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:repository/core/remote/repository_api.dart';
import 'package:repository/environment.dart';

final prettyDioLoggerProvider = Provider(
  (ref) => PrettyDioLogger(
    request: false,
    requestHeader: true,
    requestBody: false,
    responseBody: true,
    responseHeader: false,
    error: true,
    compact: true,
    maxWidth: 300,
  ),
);

final dioProvider = Provider<Dio>(
  (ref) => Dio()
    ..options = BaseOptions(baseUrl: Environment.baseUrl)
    ..interceptors.add(ref.read(prettyDioLoggerProvider)),
);

final repositoryAPIProvider = Provider((ref) => RepositoryApi(
      ref.read(dioProvider),
    ));
