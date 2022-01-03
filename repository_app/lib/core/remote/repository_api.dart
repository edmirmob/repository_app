import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:repository/core/data/repositories.dart';

part 'repository_api.g.dart';

@RestApi()
abstract class RepositoryApi {
  factory RepositoryApi(Dio dio, {String baseUrl}) = _RepositoryApi;

  @GET("/repositories?q=zagor")
  Future<List<Item>> getRepository();
}
