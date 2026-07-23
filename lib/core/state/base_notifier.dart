import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseNotifier<T> extends StateNotifier<AsyncValue<List<T>>> {
  BaseNotifier() : super(const AsyncValue.loading());

  /// Child classes must implement this
  Future<List<T>> fetchData();

  /// Initial load
  Future<void> load() async {
    state = const AsyncValue.loading();

    try {
      final data = await fetchData();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Refresh without changing state to loading first
  Future<void> refresh() async {
    try {
      final data = await fetchData();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Safe helper to execute API calls
  Future<R> execute<R>(Future<R> Function() action) async {
    try {
      return await action();
    } catch (e) {
      rethrow;
    }
  }
}