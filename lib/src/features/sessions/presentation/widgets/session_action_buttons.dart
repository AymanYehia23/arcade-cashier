import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';

class SessionActionButtons extends StatelessWidget {
  final VoidCallback? onTogglePause;
  final VoidCallback onCheckout;
  final VoidCallback onCancel;
  final bool isCheckoutLoading;
  final bool isQuickOrder;
  final bool isPaused;

  const SessionActionButtons({
    super.key,
    this.onTogglePause,
    required this.onCheckout,
    required this.onCancel,
    this.isCheckoutLoading = false,
    this.isQuickOrder = false,
    this.isPaused = false,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 8),
        if (onTogglePause != null)
          TextButton.icon(
            onPressed: onTogglePause,
            icon: Icon(isPaused ? Icons.play_arrow : Icons.pause),
            label: Text(isPaused ? loc.resume : loc.pause),
          ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: isCheckoutLoading ? null : onCancel,
          child: Text(loc.cancel),
        ),
        const SizedBox(width: 8),
        if (isCheckoutLoading)
          const CircularProgressIndicator()
        else
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            onPressed: onCheckout,
            child: Text(isQuickOrder ? 'Checkout & Print' : loc.stopSession),
          ),
      ],
    );
  }
}
