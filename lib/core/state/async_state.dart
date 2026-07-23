import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncStateExtension<T> on AsyncValue<T> {
  bool get isLoading => this is AsyncLoading<T>;

  bool get hasData =>
      this is AsyncData<T> &&
      (this as AsyncData<T>).value != null;

  bool get hasError => this is AsyncError<T>;

  T? get dataOrNull {
    if (this is AsyncData<T>) {
      return (this as AsyncData<T>).value;
    }
    return null;
  }

  String? get errorMessage {
    if (this is AsyncError<T>) {
      final error = (this as AsyncError<T>).error;
      return error.toString().replaceFirst("Exception: ", "");
    }
    return null;
  }
}