import 'package:arcade_cashier/src/features/invoices/domain/payment_method.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';

/// A reusable segmented button for selecting [PaymentMethod].
class PaymentMethodSelector extends StatelessWidget {
  const PaymentMethodSelector({
    super.key,
    required this.selected,
    required this.onSelectionChanged,
  });

  final PaymentMethod selected;
  final ValueChanged<PaymentMethod> onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(loc.paymentMethodLabel, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        SegmentedButton<PaymentMethod>(
          segments: [
            ButtonSegment<PaymentMethod>(
              value: PaymentMethod.cash,
              label: Text(loc.cash),
              icon: const Icon(Icons.money),
            ),
            ButtonSegment<PaymentMethod>(
              value: PaymentMethod.digital,
              label: Text(loc.digital),
              icon: const Icon(Icons.credit_card),
            ),
          ],
          selected: {selected},
          onSelectionChanged: (newSelection) {
            onSelectionChanged(newSelection.first);
          },
          style: SegmentedButton.styleFrom(
            selectedBackgroundColor: theme.colorScheme.primaryContainer,
            selectedForegroundColor: theme.colorScheme.onPrimaryContainer,
          ),
        ),
      ],
    );
  }
}
