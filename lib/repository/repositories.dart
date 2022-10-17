import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../constants/api_routes.dart';
import '../models/blog.dart';

part 'repositories.g.dart';

@RestApi(baseUrl: ApiRoutes.basedUrl)
abstract class Repositories
{
  factory Repositories(Dio dio, {String? baseUrl}) = _Repositories;

  @GET(ApiRoutes.blog)
  Future<List<Blog>> getBlog();
}