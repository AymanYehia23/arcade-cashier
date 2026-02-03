import 'package:arcade_cashier/src/features/orders/domain/order.dart';
import 'package:arcade_cashier/src/features/orders/presentation/session_orders_controller.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionOrderList extends ConsumerWidget {
  final AsyncValue<List<Order>> ordersAsync;

  const SessionOrderList({super.key, required this.ordersAsync});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    return ordersAsync.when(
      data: (orders) {
        if (orders.isEmpty) {
          return Center(child: Text(loc.noOrdersYet));
        }
        return ListView.separated(
          itemCount: orders.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final order = orders[index];
            final productName =
                order.product?.name ??
                loc.unknownProduct(order.productId.toString());
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
                  Text('${order.totalPrice} ${loc.egp}'),
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
      error: (e, s) => Center(child: Text(loc.errorLoadingOrders)),
    );
  }
}
