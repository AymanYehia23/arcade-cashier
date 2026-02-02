import 'package:arcade_cashier/src/features/orders/presentation/session_orders_controller.dart';
import 'package:arcade_cashier/src/features/products/domain/product.dart';
import 'package:arcade_cashier/src/features/products/presentation/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductSelectionGrid extends ConsumerWidget {
  final int sessionId;

  const ProductSelectionGrid({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsValue = ref.watch(productsProvider);

    return productsValue.when(
      data: (products) {
        if (products.isEmpty) {
          return const Center(child: Text('No active products'));
        }
        return GridView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: 1.0,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return _ProductCard(product: product, sessionId: sessionId);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }
}

class _ProductCard extends ConsumerWidget {
  final Product product;
  final int sessionId;

  const _ProductCard({required this.product, required this.sessionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          ref
              .read(sessionOrdersControllerProvider.notifier)
              .addOrder(
                sessionId: sessionId,
                productId: product.id,
                price: product.sellingPrice,
              );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                product.name,
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '${product.sellingPrice} EGP',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
