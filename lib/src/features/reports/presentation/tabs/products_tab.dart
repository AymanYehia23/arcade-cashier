import 'package:arcade_cashier/src/common_widgets/error_state_widget.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:arcade_cashier/src/utils/error_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../reports_providers.dart';

class ProductsTab extends ConsumerWidget {
  const ProductsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final productsAsync = ref.watch(topProductsProvider);

    return productsAsync.when(
      data: (products) {
        if (products.isEmpty) {
          return Center(child: Text(loc.noProductData));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: DataTable(
            columns: [
              DataColumn(label: Text(loc.rankSymbol)),
              DataColumn(label: Text(loc.productName)),
              DataColumn(label: Text(loc.qtySold), numeric: true),
              DataColumn(label: Text(loc.tableRevenue), numeric: true),
            ],
            rows: products.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isTop = index == 0;

              return DataRow(
                cells: [
                  DataCell(
                    Row(
                      children: [
                        Text('${index + 1}'),
                        if (isTop) ...[
                          const SizedBox(width: 8),
                          const Icon(Icons.emoji_events, color: Colors.amber),
                        ],
                      ],
                    ),
                  ),
                  DataCell(Text(item.productName)),
                  DataCell(Text('${item.totalSold}')),
                  DataCell(
                    Text(
                      NumberFormat.currency(
                        symbol: loc.egp,
                      ).format(item.revenue),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => ErrorStateWidget(
        message: getUserFriendlyErrorMessage(err, context),
        onRetry: () => ref.invalidate(topProductsProvider),
      ),
    );
  }
}
