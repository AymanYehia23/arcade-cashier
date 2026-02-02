import 'package:arcade_cashier/src/features/orders/data/orders_repository.dart';
import 'package:arcade_cashier/src/features/orders/domain/order.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseOrdersRepository implements OrdersRepository {
  final SupabaseClient _supabase;

  SupabaseOrdersRepository(this._supabase);

  @override
  Future<void> addOrder({
    required int sessionId,
    required int productId,
    required int quantity,
    required double unitPrice,
  }) async {
    await _supabase.rpc(
      'add_order_item',
      params: {
        'p_session_id': sessionId,
        'p_product_id': productId,
        'p_price': unitPrice,
        'p_quantity': quantity,
      },
    );
  }

  @override
  Stream<List<Order>> watchSessionOrders(int sessionId) {
    return _supabase
        .from('session_orders')
        .stream(primaryKey: ['id'])
        .eq('session_id', sessionId)
        .asyncMap((_) async {
          final data = await _supabase
              .from('session_orders')
              .select('*, products(*)')
              .eq('session_id', sessionId)
              .order('created_at', ascending: true);
          return (data as List).map((json) => Order.fromJson(json)).toList();
        });
  }

  @override
  Future<List<Order>> getOrdersForSession(int sessionId) async {
    final data = await _supabase
        .from('session_orders')
        .select('*, products(*)')
        .eq('session_id', sessionId)
        .order('created_at', ascending: true);
    return (data as List).map((json) => Order.fromJson(json)).toList();
  }

  @override
  Future<void> deleteOrder(int orderId) async {
    final response = await _supabase
        .from('session_orders')
        .select('quantity')
        .eq('id', orderId)
        .single();

    final int quantity = response['quantity'] as int;

    if (quantity > 1) {
      await _supabase
          .from('session_orders')
          .update({'quantity': quantity - 1})
          .eq('id', orderId);
    } else {
      await _supabase.from('session_orders').delete().eq('id', orderId);
    }
  }
}
