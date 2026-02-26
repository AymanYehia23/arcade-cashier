import 'package:arcade_cashier/src/common_widgets/error_state_widget.dart';
import 'package:arcade_cashier/src/common_widgets/logo_loading_indicator.dart';
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
    final locale = Localizations.localeOf(context);
    final productsAsync = ref.watch(topProductsProvider);

    return productsAsync.when(
      data: (products) {
        if (products.isEmpty) {
          return Center(child: Text(loc.noProductData));
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            // Use card layout on mobile, table on larger screens
            final isMobile = constraints.maxWidth < 600;

            if (isMobile) {
              // Mobile: Card-based layout
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final item = products[index];
                  final isTop = index == 0;

                  return _ProductCard(
                    rank: index + 1,
                    product: item,
                    isTop: isTop,
                    locale: locale,
                    loc: loc,
                  );
                },
              );
            } else {
              // Desktop/Tablet: Table layout
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
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
                                  const Icon(
                                    Icons.emoji_events,
                                    color: Colors.amber,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          DataCell(Text(item.getLocalizedName(locale))),
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
                ),
              );
            }
          },
        );
      },
      loading: () => const Center(child: LogoLoadingIndicator()),
      error: (err, stack) => ErrorStateWidget(
        message: getUserFriendlyErrorMessage(err, context),
        onRetry: () => ref.invalidate(topProductsProvider),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final int rank;
  final dynamic product;
  final bool isTop;
  final Locale locale;
  final AppLocalizations loc;

  const _ProductCard({
    required this.rank,
    required this.product,
    required this.isTop,
    required this.locale,
    required this.loc,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isTop ? 4 : 1,
      color: isTop
          ? Theme.of(
              context,
            ).colorScheme.primaryContainer.withValues(alpha: 0.3)
          : null,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Rank with trophy icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isTop
                    ? Colors.amber.withValues(alpha: 0.2)
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isTop)
                    const Icon(
                      Icons.emoji_events,
                      color: Colors.amber,
                      size: 20,
                    )
                  else
                    Text(
                      '$rank',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Product info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.getLocalizedName(locale),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _InfoItem(
                          label: loc.qtySold,
                          value: '${product.totalSold}',
                        ),
                      ),
                      Expanded(
                        child: _InfoItem(
                          label: loc.tableRevenue,
                          value: NumberFormat.currency(
                            symbol: loc.egp,
                          ).format(product.revenue),
                          isHighlight: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isHighlight;

  const _InfoItem({
    required this.label,
    required this.value,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
