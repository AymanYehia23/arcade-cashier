import 'package:arcade_cashier/src/features/products/domain/product.dart';
import 'package:arcade_cashier/src/features/products/presentation/products_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_search_provider.g.dart';

@riverpod
class ProductSearchQuery extends _$ProductSearchQuery {
  @override
  String build() {
    return '';
  }

  void setQuery(String query) {
    state = query;
  }
}

@riverpod
AsyncValue<List<Product>> filteredProducts(Ref ref) {
  final productsAsync = ref.watch(productsProvider);
  final query = ref.watch(productSearchQueryProvider).toLowerCase();

  return productsAsync.whenData((products) {
    var filtered = products;
    if (query.isNotEmpty) {
      // Search across both English and Arabic names
      filtered = products.where((product) {
        final name = product.name.toLowerCase();
        final nameAr = product.nameAr.toLowerCase();
        final category = product.category.toLowerCase();
        final categoryAr = product.categoryAr.toLowerCase();

        return name.contains(query) ||
            nameAr.contains(query) ||
            category.contains(query) ||
            categoryAr.contains(query);
      }).toList();
    }

    // Sort by English category then English name
    // Note: Sorting uses English for consistency across languages
    filtered.sort((a, b) {
      final categoryComparison = a.category.compareTo(b.category);
      if (categoryComparison != 0) {
        return categoryComparison;
      }
      return a.name.compareTo(b.name);
    });

    return filtered;
  });
}
