import 'package:arcade_cashier/src/core/supabase_provider.dart';
import 'package:arcade_cashier/src/features/orders/data/supabase_orders_repository.dart';
import 'package:arcade_cashier/src/features/orders/domain/order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'orders_repository.g.dart';

abstract interface class OrdersRepository {
  Future<void> addOrder({
    required int sessionId,
    required int productId,
    required int quantity,
    required double unitPrice,
  });

  Stream<List<Order>> watchSessionOrders(int sessionId);

  Future<void> deleteOrder(int orderId);
}

@Riverpod(keepAlive: true)
OrdersRepository ordersRepository(Ref ref) {
  return SupabaseOrdersRepository(ref.watch(supabaseProvider));
}
