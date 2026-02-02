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
      filtered = products
          .where((product) => product.name.toLowerCase().contains(query))
          .toList();
    }

    // Sort by Category then Name
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
