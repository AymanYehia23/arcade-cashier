import 'package:arcade_cashier/src/common_widgets/responsive_center.dart';
import 'package:arcade_cashier/src/common_widgets/error_state_widget.dart';
import 'package:arcade_cashier/src/constants/app_sizes.dart';
import 'package:arcade_cashier/src/features/products/presentation/products_controller.dart';
import 'package:arcade_cashier/src/features/products/application/products_search_provider.dart';
import 'package:arcade_cashier/src/features/products/domain/product.dart';
import 'package:arcade_cashier/src/features/products/presentation/product_form_dialog.dart';
import 'package:arcade_cashier/src/features/products/presentation/widgets/product_dashboard_card.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:arcade_cashier/src/utils/error_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

class ProductsDashboardScreen extends ConsumerWidget {
  const ProductsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final productsValue = ref.watch(filteredProductsProvider);

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const ProductFormDialog(),
            );
          },
          icon: const Icon(Icons.add),
          label: Text(loc.addProduct),
        ),
        body: ResponsiveCenter(
          maxContentWidth: 1200, // Or whatever the standard max width is
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSizes.p16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: loc.search, // Use localized "Search"
                          prefixIcon: const Icon(Icons.search),
                          border: const OutlineInputBorder(),
                          filled: true,
                        ),
                        onChanged: (value) {
                          ref
                              .read(productSearchQueryProvider.notifier)
                              .setQuery(value);
                        },
                      ),
                    ),
                    const SizedBox(width: AppSizes.p16),
                    IconButton.filledTonal(
                      onPressed: () {
                        ref.invalidate(productSearchQueryProvider);
                        ref.invalidate(productsProvider);
                      },
                      icon: const Icon(Icons.refresh),
                      tooltip: loc.retry,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: productsValue.when(
                  data: (products) {
                    if (products.isEmpty) {
                      return Center(child: Text(loc.noProductsFound));
                    }

                    // Group products by category
                    final groupedProducts = groupBy(
                      products,
                      (Product p) => p.category,
                    );

                    return CustomScrollView(
                      slivers: [
                        for (final entry in groupedProducts.entries) ...[
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                AppSizes.p16,
                                AppSizes.p24,
                                AppSizes.p16,
                                AppSizes.p8,
                              ),
                              child: Text(
                                switch (entry.key) {
                                  'Drinks' => loc.drinks,
                                  'Snacks' => loc.snacks,
                                  'Food' => loc.food,
                                  'Other' => loc.other,
                                  _ => entry.key,
                                },
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall,
                              ),
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.p16,
                            ),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 300,
                                    mainAxisSpacing: AppSizes.p16,
                                    crossAxisSpacing: AppSizes.p16,
                                    childAspectRatio:
                                        2, // Adjust based on card content
                                  ),
                              delegate: SliverChildBuilderDelegate((
                                context,
                                index,
                              ) {
                                final product = entry.value[index];
                                return ProductDashboardCard(product: product);
                              }, childCount: entry.value.length),
                            ),
                          ),
                        ],
                        const SliverToBoxAdapter(
                          child: SizedBox(height: AppSizes.p64),
                        ), // Fabric clearance
                      ],
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, st) => ErrorStateWidget(
                    message: getUserFriendlyErrorMessage(e, context),
                    onRetry: () {
                      ref.invalidate(productSearchQueryProvider);
                      ref.invalidate(productsProvider);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
