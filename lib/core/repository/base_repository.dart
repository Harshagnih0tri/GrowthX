import 'package:dio/dio.dart';

import '../network/api_client.dart';
import '../network/api_exception.dart';

abstract class BaseRepository {
  const BaseRepository();

  Dio get dio => ApiClient.dio;

  /// Executes an API call with common Dio error handling.
  Future<T> execute<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      throw Exception(ApiException.fromDio(e));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}