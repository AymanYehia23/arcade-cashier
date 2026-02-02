import 'package:arcade_cashier/src/core/supabase_provider.dart';
import 'package:arcade_cashier/src/features/products/data/supabase_products_repository.dart';
import 'package:arcade_cashier/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_repository.g.dart';

abstract interface class ProductsRepository {
  Stream<List<Product>> watchProducts();
  Future<void> createProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(int id);
}

@Riverpod(keepAlive: true)
ProductsRepository productsRepository(Ref ref) {
  return SupabaseProductsRepository(ref.watch(supabaseProvider));
}
