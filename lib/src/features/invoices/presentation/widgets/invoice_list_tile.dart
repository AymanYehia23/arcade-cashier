import 'package:arcade_cashier/src/features/invoices/domain/invoice.dart';
import 'package:arcade_cashier/src/features/invoices/presentation/invoice_reprint_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// List tile for displaying invoice in history with tap to reprint.
class InvoiceListTile extends ConsumerWidget {
  const InvoiceListTile({super.key, required this.invoice});

  final Invoice invoice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final issuedDate = invoice.issuedAt ?? DateTime.now();
    final controllerState = ref.watch(invoiceReprintControllerProvider);

    return ListTile(
      leading: const Icon(Icons.receipt_long),
      title: Text(
        invoice.invoiceNumber,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(dateFormat.format(issuedDate)),
      trailing: Text(
        '${invoice.totalAmount.toStringAsFixed(2)} EGP',
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
      onTap: controllerState.isLoading
          ? null
          : () {
              ref
                  .read(invoiceReprintControllerProvider.notifier)
                  .reprintInvoice(context, invoice.id!);
            },
    );
  }
}
