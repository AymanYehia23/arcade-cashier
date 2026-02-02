import 'package:arcade_cashier/src/features/products/data/products_repository.dart';
import 'package:arcade_cashier/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_controller.g.dart';

@riverpod
Stream<List<Product>> products(Ref ref) {
  final repository = ref.watch(productsRepositoryProvider);
  return repository.watchProducts();
}

@riverpod
class ProductFormController extends _$ProductFormController {
  @override
  FutureOr<void> build() {
    // Initial state is void (data)
  }

  Future<void> createProduct(Product product) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(productsRepositoryProvider).createProduct(product),
    );
    if (!state.hasError) {
      ref.invalidate(productsProvider);
    }
  }

  Future<void> updateProduct(Product product) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(productsRepositoryProvider).updateProduct(product),
    );
    if (!state.hasError) {
      ref.invalidate(productsProvider);
    }
  }

  Future<void> deleteProduct(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(productsRepositoryProvider).deleteProduct(id),
    );
    if (!state.hasError) {
      ref.invalidate(productsProvider);
    }
  }
}
