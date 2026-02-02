import 'package:arcade_cashier/src/features/billing/application/billing_service.dart';
import 'package:arcade_cashier/src/features/orders/domain/order.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late BillingService billingService;

  setUp(() {
    billingService = BillingService();
  });

  group('BillingService', () {
    test('calculateSessionBill - Quick Order (Walk-in)', () {
      final session = Session(
        id: 1,
        startTime: DateTime.now(),
        appliedHourlyRate: 0,
        isMultiMatch: false,
        source: 'walk_in',
        roomId: null, // Quick order
      );

      final orders = [
        Order(
          id: 1,
          sessionId: 1,
          productId: 101,
          quantity: 2,
          unitPrice: 50.0,
          totalPrice: 100.0,
          createdAt: DateTime.now(),
        ),
      ];

      final bill = billingService.calculateSessionBill(session, orders);

      expect(bill.timeCost, 0.0);
      expect(bill.ordersTotal, 100.0);
      expect(bill.totalAmount, 100.0);
      expect(bill.duration, Duration.zero);
    });

    test('calculateSessionBill - Fixed Session', () {
      final startTime = DateTime(2023, 1, 1, 10, 0); // 10:00 AM
      const durationMinutes = 90; // 1.5 hours
      const hourlyRate = 100.0;

      final session = Session(
        id: 2,
        startTime: startTime,
        appliedHourlyRate: hourlyRate,
        isMultiMatch: false,
        sessionType: SessionType.fixed,
        plannedDurationMinutes: durationMinutes,
        roomId: 123,
      );

      // 1.5 hours * 100 = 150.0
      // Mock orders: 1 item * 50 = 50.0
      // Total should be 200.0

      final orders = [
        Order(
          id: 2,
          sessionId: 2,
          productId: 102,
          quantity: 1,
          unitPrice: 50.0,
          totalPrice: 50.0,
          createdAt: DateTime.now(),
        ),
      ];

      final bill = billingService.calculateSessionBill(session, orders);

      expect(bill.timeCost, 150.0);
      expect(bill.ordersTotal, 50.0);
      expect(bill.totalAmount, 200.0);
      expect(bill.duration, const Duration(minutes: 90));
    });

    test('calculateSessionBill - Open Session', () {
      final startTime = DateTime(2023, 1, 1, 10, 0); // 10:00 AM
      final currentTime = DateTime(
        2023,
        1,
        1,
        12,
        30,
      ); // 12:30 PM (2.5 hours elapsed)
      const hourlyRate = 60.0; // 60 EGP/hr => 1 EGP/min

      final session = Session(
        id: 3,
        startTime: startTime,
        appliedHourlyRate: hourlyRate,
        isMultiMatch: false,
        sessionType: SessionType.open,
        roomId: 456,
      );

      // Duration: 2.5 hours
      // Time Cost: 2.5 * 60 = 150.0
      // Orders: 0

      final bill = billingService.calculateSessionBill(
        session,
        [],
        currentTime: currentTime,
      );

      expect(bill.duration, const Duration(hours: 2, minutes: 30));
      expect(bill.timeCost, 150.0);
      expect(bill.ordersTotal, 0.0);
      expect(bill.totalAmount, 150.0);
    });

    test('calculateSessionBill - Rounding Check', () {
      // Test rounding with non-clean numbers
      // 100 EGP/hr. 20 minutes duration.
      // 20/60 = 1/3 hours = 0.33333...
      // Cost = 33.3333...
      // Should round to 33.33

      final startTime = DateTime(2023, 1, 1, 10, 0);
      final currentTime = DateTime(2023, 1, 1, 10, 20); // 20 mins
      const hourlyRate = 100.0;

      final session = Session(
        id: 4,
        startTime: startTime,
        appliedHourlyRate: hourlyRate,
        isMultiMatch: false,
        sessionType: SessionType.open,
        roomId: 789,
      );

      final bill = billingService.calculateSessionBill(
        session,
        [],
        currentTime: currentTime,
      );

      expect(bill.timeCost, 33.33);
      expect(bill.totalAmount, 33.33);
    });
  });
}
