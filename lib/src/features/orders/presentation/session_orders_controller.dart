import 'package:arcade_cashier/src/features/orders/data/orders_repository.dart';
import 'package:arcade_cashier/src/features/orders/domain/order.dart';
import 'package:arcade_cashier/src/features/products/presentation/products_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_orders_controller.g.dart';

@riverpod
Stream<List<Order>> sessionOrders(Ref ref, int sessionId) {
  final repository = ref.watch(ordersRepositoryProvider);
  return repository.watchSessionOrders(sessionId);
}

@riverpod
class SessionOrdersController extends _$SessionOrdersController {
  @override
  FutureOr<void> build() {
    // Initial state is void (idle)
  }

  Future<void> addOrder({
    required int sessionId,
    required int productId,
    required double price,
    int quantity = 1,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => _addOrderInternal(
        sessionId: sessionId,
        productId: productId,
        price: price,
        quantity: quantity,
      ),
    );

    if (!state.hasError) {
      ref.invalidate(sessionOrdersProvider(sessionId));
      ref.invalidate(productsProvider);
    }
  }

  Future<void> _addOrderInternal({
    required int sessionId,
    required int productId,
    required double price,
    required int quantity,
  }) async {
    final repository = ref.read(ordersRepositoryProvider);
    await repository.addOrder(
      sessionId: sessionId,
      productId: productId,
      unitPrice: price,
      quantity: quantity,
    );
  }

  Future<void> deleteOrder(int orderId, int sessionId) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => ref.read(ordersRepositoryProvider).deleteOrder(orderId),
    );

    if (!state.hasError) {
      ref.invalidate(sessionOrdersProvider(sessionId));
      ref.invalidate(productsProvider);
    }
  }
}
