import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arcade_cashier/src/features/products/domain/product.dart';
import 'package:arcade_cashier/src/features/products/presentation/products_controller.dart';
import 'package:arcade_cashier/src/features/products/presentation/product_form_dialog.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';

class ProductDashboardCard extends ConsumerWidget {
  final Product product;

  const ProductDashboardCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Determine Status Logic
    final isOutOfStock = product.stockQuantity == 0;
    final isLowStock = !isOutOfStock && product.stockQuantity <= 5;

    final statusColor = isOutOfStock
        ? Colors.redAccent
        : isLowStock
        ? Colors.orangeAccent
        : const Color(0xFF00E676); // Neon Green

    // 2. Determine Category Icon
    final IconData bgIcon = _getCategoryIcon(product.category);

    return Container(
      height: 110, // Fixed compact height
      decoration: BoxDecoration(
        color: const Color(0xFF2A2D3E), // Deep Blue/Grey Surface
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // A. Background Icon (Decoration)
            Positioned(
              right: -15,
              bottom: -15,
              child: Icon(
                bgIcon,
                size: 90,
                color: Colors.white.withOpacity(0.05), // Very faint watermark
              ),
            ),

            // B. Content Row
            Row(
              children: [
                // Left Status Strip
                Container(
                  width: 6,
                  height: double.infinity,
                  color: statusColor,
                ),

                // Main Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Header: Name & Menu
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  height: 1.1,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // Quick Action: Edit
                            InkWell(
                              onTap: () => _showEditDialog(context, product),
                              borderRadius: BorderRadius.circular(20),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: Colors.white38,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Footer: Price & Stock
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Price
                            Text(
                              '${product.sellingPrice.toStringAsFixed(0)} ${AppLocalizations.of(context)!.egp}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF4FC3F7), // Neon Blue
                              ),
                            ),

                            // Stock Label
                            Text(
                              isOutOfStock
                                  ? AppLocalizations.of(
                                      context,
                                    )!.outOfStockLabel
                                  : AppLocalizations.of(
                                      context,
                                    )!.stockLeft(product.stockQuantity),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: statusColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // C. Tap Handler (Full Card Ripple)
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _showEditDialog(context, product),
                  onLongPress: () => _confirmDelete(context, ref),
                  overlayColor: WidgetStateProperty.all(
                    Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    final cat = category.toLowerCase();
    if (cat.contains('drink') ||
        cat.contains('coffee') ||
        cat.contains('tea')) {
      return Icons.local_cafe;
    } else if (cat.contains('snack') || cat.contains('food')) {
      return Icons.fastfood;
    } else if (cat.contains('device') || cat.contains('pad')) {
      return Icons.gamepad;
    }
    return Icons.inventory_2; // Default box icon
  }

  void _showEditDialog(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (_) => ProductFormDialog(product: product), // Fixed param name
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C3E),
        title: Text(
          AppLocalizations.of(context)!.deleteProductTitle,
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          AppLocalizations.of(context)!.deleteProductMessage(product.name),
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(productFormControllerProvider.notifier)
                  .deleteProduct(product.id);
              Navigator.pop(ctx);
            },
            child: Text(
              AppLocalizations.of(context)!.deleteButton,
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }
}
