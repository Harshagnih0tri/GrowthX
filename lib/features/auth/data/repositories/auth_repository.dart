import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/storage/token_storage.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

class AuthRepository {
  final Dio _dio = ApiClient.dio;

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _dio.post(
      "/auth/login",
      data: request.toJson(),
    );

    final loginResponse = LoginResponse.fromJson(response.data);

    await TokenStorage.saveToken(loginResponse.accessToken);

    return loginResponse;
  }
}