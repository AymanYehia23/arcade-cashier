import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    if (!isLoading && hasError) {
      final message = error.toString();
      final loc = AppLocalizations.of(context);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(loc?.errorTitle ?? 'Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(loc?.ok ?? 'OK'),
            ),
          ],
        ),
      );
    }
  }
}
