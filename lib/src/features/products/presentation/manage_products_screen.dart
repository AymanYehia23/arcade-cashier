import 'package:arcade_cashier/src/common_widgets/responsive_center.dart';
import 'package:arcade_cashier/src/features/products/domain/product.dart';
import 'package:arcade_cashier/src/features/products/presentation/product_form_dialog.dart';
import 'package:arcade_cashier/src/features/products/presentation/products_controller.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:arcade_cashier/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageProductsScreen extends ConsumerWidget {
  const ManageProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsValue = ref.watch(productsProvider);
    final loc = AppLocalizations.of(context)!;

    // Listen for errors in creating/deleting (if exposed via same provider or separate)
    // Here we mainly listen to productFormController for errors in the dialog,
    // but we might want to delete products here directly.

    // Check if we need to listen to delete errors if delete is handled by productFormController
    // or a separate controller. In previous file I added delete to ProductFormController.
    ref.listen<AsyncValue>(
      productFormControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    return Scaffold(
      appBar: AppBar(title: Text(loc.manageInventory)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const ProductFormDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ResponsiveCenter(
        maxContentWidth: 600,
        child: productsValue.when(
          data: (products) {
            if (products.isEmpty) {
              return Center(child: Text(loc.noProductsFound));
            }
            return ListView.builder(
              itemCount: products.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final product = products[index];
                return _ProductCard(product: product);
              },
            );
          },
          loading: () =>
              const Center(child: CircularProgressIndicator.adaptive()),
          error: (e, st) => Center(child: Text(loc.errorMessage(e.toString()))),
        ),
      ),
    );
  }
}

class _ProductCard extends ConsumerWidget {
  final Product product;

  const _ProductCard({required this.product});

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Drinks':
        return Icons.local_drink;
      case 'Snacks':
        return Icons.cookie;
      case 'Food':
        return Icons.restaurant;
      default:
        return Icons.inventory;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Determine stock color
    final isLowStock = product.stockQuantity < 5;
    final stockColor = isLowStock ? Colors.red : null;
    final loc = AppLocalizations.of(context)!;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(child: Icon(_getCategoryIcon(product.category))),
        title: Text(product.name),
        subtitle: Text(
          loc.productPriceStock(product.sellingPrice, product.stockQuantity),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLowStock)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  loc.lowStock,
                  style: TextStyle(
                    color: stockColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => ProductFormDialog(product: product),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      loc.deleteRoom.replaceAll('Room', 'Product'),
                    ), // Reuse or new key
                    content: const Text(
                      'Are you sure you want to delete this product?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(loc.cancel),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text(
                          loc.deleteRoom.replaceAll('Room', ''),
                        ), // "Delete"
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  ref
                      .read(productFormControllerProvider.notifier)
                      .deleteProduct(product.id);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
