import 'package:flutter/material.dart';

/// A reusable error state widget that displays a user-friendly error message
/// with a retry button.
///
/// Designed to be used in AsyncValue.when() error handlers across the app.
class ErrorStateWidget extends StatelessWidget {
  /// The user-friendly error message to display
  final String message;

  /// Callback when the retry button is pressed
  final VoidCallback onRetry;

  /// Optional custom icon to display (defaults to error_outline)
  final IconData? icon;

  const ErrorStateWidget({
    super.key,
    required this.message,
    required this.onRetry,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error Icon
            Icon(
              icon ?? Icons.error_outline,
              size: 80,
              color: Colors.grey.shade600,
            ),
            const SizedBox(height: 24),

            // Heading
            Text(
              'Something Went Wrong',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Error Message
            Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade400),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Retry Button
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
