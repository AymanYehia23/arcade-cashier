import 'package:arcade_cashier/src/features/orders/domain/order.dart';
import 'package:arcade_cashier/src/features/orders/presentation/session_orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionOrderList extends ConsumerWidget {
  final AsyncValue<List<Order>> ordersAsync;

  const SessionOrderList({super.key, required this.ordersAsync});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ordersAsync.when(
      data: (orders) {
        if (orders.isEmpty) {
          return const Center(child: Text('No orders yet'));
        }
        return ListView.separated(
          itemCount: orders.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final order = orders[index];
            final productName =
                order.product?.name ?? 'Unknown #${order.productId}';
            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text(
                productName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${order.quantity} x ${order.unitPrice}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${order.totalPrice} EGP'),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      ref
                          .read(sessionOrdersControllerProvider.notifier)
                          .deleteOrder(order.id, order.sessionId);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => const Center(child: Text('Error loading orders')),
    );
  }
}
