import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import '../domain/habit_model.dart';

class HabitRepository {
  final Dio _dio = ApiClient.dio;

  Future<List<Habit>> getHabits() async {
    try {
      final response = await _dio.get('/habits/');
      final List<dynamic> data = response.data;
      return data.map((json) => Habit.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load habits: ${_errorMessage(e)}');
    }
  }

  Future<Habit> createHabit({
    required String name,
    String? description,
    required String frequency,
  }) async {
    try {
      final response = await _dio.post(
        '/habits/',
        data: {
          'name': name,
          'description': description,
          'frequency': frequency,
        },
      );
      return Habit.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to create habit: ${_errorMessage(e)}');
    }
  }

  Future<Habit> updateHabit(
    String id, {
    String? name,
    String? description,
    String? frequency,
  }) async {
    try {
      final response = await _dio.put(
        '/habits/$id',
        data: {
          if (name != null) 'name': name,
          if (description != null) 'description': description,
          if (frequency != null) 'frequency': frequency,
        },
      );
      return Habit.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to update habit: ${_errorMessage(e)}');
    }
  }

  Future<void> deleteHabit(String id) async {
    try {
      await _dio.delete('/habits/$id');
    } on DioException catch (e) {
      throw Exception('Failed to delete habit: ${_errorMessage(e)}');
    }
  }

  String _errorMessage(DioException e) {
    if (e.response?.data is Map && e.response?.data['detail'] != null) {
      return e.response!.data['detail'].toString();
    }
    return e.message ?? 'Unknown network error';
  }
}