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
    await _supabase.from('session_orders').insert({
      'session_id': sessionId,
      'product_id': productId,
      'quantity': quantity,
      'unit_price': unitPrice,
    });
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
  Future<void> deleteOrder(int orderId) async {
    await _supabase.from('session_orders').delete().eq('id', orderId);
  }
}
