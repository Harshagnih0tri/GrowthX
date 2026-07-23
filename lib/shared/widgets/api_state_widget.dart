import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiStateWidget<T> extends StatelessWidget {
  final AsyncValue<T> state;
  final Widget Function(T data) builder;
  final VoidCallback? onRetry;
  final String emptyMessage;
  final IconData emptyIcon;

  const ApiStateWidget({
    super.key,
    required this.state,
    required this.builder,
    this.onRetry,
    this.emptyMessage = "No data available",
    this.emptyIcon = Icons.inbox_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return state.when(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      ),

      error: (error, stackTrace) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 48,
              ),
              const SizedBox(height: 12),
              Text(
                error.toString().replaceFirst("Exception: ", ""),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              if (onRetry != null)
                ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Retry"),
                ),
            ],
          ),
        ),
      ),

      data: (data) {
        if (data is List && data.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    emptyIcon,
                    size: 48,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    emptyMessage,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        return builder(data);
      },
    );
  }
}