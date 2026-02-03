import 'package:arcade_cashier/src/common_widgets/error_state_widget.dart';
import 'package:arcade_cashier/src/utils/error_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  /// Shows a snackbar with error message when AsyncValue has an error
  void showAlertDialogOnError(BuildContext context) {
    if (!isLoading && hasError) {
      final message = getUserFriendlyErrorMessage(error!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    }
  }

  /// Builds an error state widget when AsyncValue has an error
  ///
  /// Returns an ErrorStateWidget with user-friendly message and retry callback.
  /// Use this in AsyncValue.when() error handlers.
  Widget buildErrorWidget({
    required VoidCallback onRetry,
    String? customMessage,
    IconData? icon,
  }) {
    return ErrorStateWidget(
      message: customMessage ?? getUserFriendlyErrorMessage(error!),
      onRetry: onRetry,
      icon: icon,
    );
  }
}
