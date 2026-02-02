import 'package:arcade_cashier/src/features/invoices/data/invoices_repository.dart';
import 'package:arcade_cashier/src/features/invoices/domain/invoice.dart';
import 'package:arcade_cashier/src/features/invoices/presentation/widgets/invoice_list_tile.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Screen displaying history of all invoices with reprint capability.
class InvoicesHistoryScreen extends ConsumerWidget {
  const InvoicesHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final invoicesAsync = ref.watch(invoiceHistoryStreamProvider);

    return Scaffold(
      appBar: AppBar(title: Text(loc.invoiceHistory)),
      body: invoicesAsync.when(
        data: (invoices) => _InvoicesList(invoices: invoices, loc: loc),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(loc.errorMessage(e.toString()))),
      ),
    );
  }
}

class _InvoicesList extends StatelessWidget {
  const _InvoicesList({required this.invoices, required this.loc});

  final List<Invoice> invoices;
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    if (invoices.isEmpty) {
      return Center(child: Text(loc.noInvoicesFound));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: invoices.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final invoice = invoices[index];
        return InvoiceListTile(invoice: invoice);
      },
    );
  }
}
