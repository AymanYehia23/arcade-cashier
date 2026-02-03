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
    double discountPercentage = 0.0,
  }) {
    if (session.isQuickOrder) {
      return _calculateQuickOrderBill(
        orders,
        discountPercentage: discountPercentage,
      );
    }

    // 1. Calculate Duration
    final now = currentTime ?? DateTime.now();
    final startTimeLocal = session.startTime.toLocal();
    Duration duration;

    if (session.sessionType == SessionType.open) {
      final totalPaused = Duration(seconds: session.totalPausedDurationSeconds);
      // If currently paused, duration stops accumulating at pausedAt
      final endPoint = session.pausedAt ?? now;
      duration = endPoint.difference(startTimeLocal) - totalPaused;

      if (duration.isNegative) {
        duration = Duration.zero;
      }
    } else {
      // Fixed session type: Pay for planned duration
      duration = Duration(minutes: session.plannedDurationMinutes ?? 0);
    }

    // 2. Calculate Raw Time Cost
    double rawTimeCost = 0.0;
    if (session.sessionType == SessionType.open) {
      final hours = duration.inMinutes / 60.0;
      rawTimeCost = hours * session.appliedHourlyRate;
    } else {
      // Fixed
      final plannedHours = (session.plannedDurationMinutes ?? 0) / 60.0;
      rawTimeCost = plannedHours * session.appliedHourlyRate;
    }

    // 3. Apply Custom Rounding Rule (Nearest 5, Half Down)
    final roundedTimeCost = _roundToNearestFive(rawTimeCost);

    // 4. Calculate Orders Total
    double ordersTotal = orders.fold(
      0.0,
      (sum, order) => sum + (order.quantity * order.unitPrice),
    );
    ordersTotal = double.parse(ordersTotal.toStringAsFixed(2));

    // 5. Grand Total
    double subtotal = roundedTimeCost + ordersTotal;

    // Calculate Discount Amount
    double discountAmount = 0.0;
    if (discountPercentage > 0) {
      discountAmount = (subtotal * discountPercentage) / 100.0;
      discountAmount = double.parse(discountAmount.toStringAsFixed(2));
    }

    double totalAmount = subtotal - discountAmount;
    if (totalAmount < 0) totalAmount = 0.0;

    totalAmount = double.parse(totalAmount.toStringAsFixed(2));

    return SessionBill(
      timeCost: roundedTimeCost,
      ordersTotal: ordersTotal,
      totalAmount: totalAmount,
      discountAmount: discountAmount,
      discountPercentage: discountPercentage,
      duration: duration,
    );
  }

  SessionBill _calculateQuickOrderBill(
    List<Order> orders, {
    double discountPercentage = 0.0,
  }) {
    double ordersTotal = orders.fold(
      0.0,
      (sum, order) => sum + (order.quantity * order.unitPrice),
    );
    ordersTotal = double.parse(ordersTotal.toStringAsFixed(2));

    double discountAmount = 0.0;
    if (discountPercentage > 0) {
      discountAmount = (ordersTotal * discountPercentage) / 100.0;
      discountAmount = double.parse(discountAmount.toStringAsFixed(2));
    }

    double totalAmount = ordersTotal - discountAmount;
    if (totalAmount < 0) totalAmount = 0.0;
    totalAmount = double.parse(totalAmount.toStringAsFixed(2));

    return SessionBill(
      timeCost: 0.0,
      ordersTotal: ordersTotal,
      totalAmount: totalAmount,
      discountAmount: discountAmount,
      discountPercentage: discountPercentage,
      duration: Duration.zero,
    );
  }

  /// Rounds to nearest 5.
  /// If remainder is <= 2.5, round DOWN.
  /// 32.0 % 5 = 2.0 -> 30.0
  /// 32.5 % 5 = 2.5 -> 30.0
  /// 32.6 % 5 = 2.6 -> 35.0
  double _roundToNearestFive(double value) {
    double remainder = value % 5;
    if (remainder <= 2.5) {
      return value - remainder; // Round Down
    } else {
      return value + (5 - remainder); // Round Up
    }
  }
}
