import 'package:arcade_cashier/src/common_widgets/error_state_widget.dart';
import 'package:arcade_cashier/src/utils/error_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../reports_providers.dart';

class ProductsTab extends ConsumerWidget {
  const ProductsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(topProductsProvider);

    return productsAsync.when(
      data: (products) {
        if (products.isEmpty) {
          return const Center(child: Text('No product data available.'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: DataTable(
            columns: const [
              DataColumn(label: Text('#')),
              DataColumn(label: Text('Product Name')),
              DataColumn(label: Text('Qty Sold'), numeric: true),
              DataColumn(label: Text('Revenue'), numeric: true),
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
                      NumberFormat.currency(symbol: '\$').format(item.revenue),
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
        message: getUserFriendlyErrorMessage(err),
        onRetry: () => ref.invalidate(topProductsProvider),
      ),
    );
  }
}
