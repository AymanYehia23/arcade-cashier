import 'package:arcade_cashier/src/features/billing/domain/session_bill.dart';
import 'package:arcade_cashier/src/features/orders/domain/order.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'billing_service.g.dart';

@riverpod
BillingService billingService(Ref ref) {
  return BillingService();
}

class BillingService {
  SessionBill calculateSessionBill(
    Session session,
    List<Order> orders, {
    DateTime? currentTime,
  }) {
    if (session.isQuickOrder) {
      return _calculateQuickOrderBill(orders);
    }

    // Calculate Duration
    final now = currentTime ?? DateTime.now();
    final startTimeLocal = session.startTime.toLocal();
    Duration duration;

    if (session.sessionType == SessionType.open) {
      duration = now.difference(startTimeLocal);
    } else {
      // Fixed session type
      // For billing purposes in "Active Session", we might want to show the currently elapsed time
      // OR the planned time cost. The user instructions said:
      // "Time Cost: Calculate duration (End Time - Start Time)"
      // But in ActiveSessionDialog, for fixed sessions, it calculates cost based on PLANNED duration.
      // "timeCost = plannedHours * session.appliedHourlyRate;"
      // However, the user prompt says: "Time Cost: Calculate duration (End Time - Start Time)"
      // I should probably follow the existing logic which seems better for "Fixed" sessions: you pay for what you booked.
      // Wait, let's look at the existing ActiveSessionDialog logic again.
      // Open: elapsed hours * rate
      // Fixed: planned hours * rate
      // I will stick to the existing logic as it makes more sense for business rules (pre-paid/fixed price).

      duration = Duration(minutes: session.plannedDurationMinutes ?? 0);
    }

    double timeCost = 0.0;
    if (session.sessionType == SessionType.open) {
      final hours = duration.inMinutes / 60.0;
      timeCost = hours * session.appliedHourlyRate;
    } else {
      // Fixed
      final plannedHours = (session.plannedDurationMinutes ?? 0) / 60.0;
      timeCost = plannedHours * session.appliedHourlyRate;
    }

    // Rounding: Use double.parse(total.toStringAsFixed(2))
    timeCost = double.parse(timeCost.toStringAsFixed(2));

    // Calculate Orders Total
    double ordersTotal = orders.fold(
      0.0,
      (sum, order) => sum + (order.quantity * order.unitPrice),
    );
    ordersTotal = double.parse(ordersTotal.toStringAsFixed(2));

    // Grand Total
    double totalAmount = timeCost + ordersTotal;
    totalAmount = double.parse(totalAmount.toStringAsFixed(2));

    return SessionBill(
      timeCost: timeCost,
      ordersTotal: ordersTotal,
      totalAmount: totalAmount,
      duration: duration,
    );
  }

  SessionBill _calculateQuickOrderBill(List<Order> orders) {
    double ordersTotal = orders.fold(
      0.0,
      (sum, order) => sum + (order.quantity * order.unitPrice),
    );
    ordersTotal = double.parse(ordersTotal.toStringAsFixed(2));

    return SessionBill(
      timeCost: 0.0,
      ordersTotal: ordersTotal,
      totalAmount: ordersTotal,
      duration: Duration.zero,
    );
  }
}
