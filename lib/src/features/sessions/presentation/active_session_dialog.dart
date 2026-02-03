import 'dart:async';

import 'package:arcade_cashier/src/features/customers/domain/customer.dart';
import 'package:arcade_cashier/src/features/customers/presentation/customer_selection_widget.dart';

import 'package:arcade_cashier/src/features/billing/application/billing_service.dart';
import 'package:arcade_cashier/src/features/billing/domain/session_bill.dart';
import 'package:arcade_cashier/src/features/invoices/presentation/invoice_preview_dialog.dart';
import 'package:arcade_cashier/src/features/invoices/presentation/session_completion_controller.dart';
import 'package:arcade_cashier/src/features/orders/domain/order.dart';
import 'package:arcade_cashier/src/features/orders/presentation/product_selection_grid.dart';
import 'package:arcade_cashier/src/features/orders/presentation/session_orders_controller.dart';
import 'package:arcade_cashier/src/features/rooms/domain/room.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session.dart';
import 'package:arcade_cashier/src/features/sessions/presentation/sessions_controller.dart';
import 'package:arcade_cashier/src/features/sessions/presentation/widgets/session_action_buttons.dart';
import 'package:arcade_cashier/src/features/sessions/presentation/widgets/session_order_list.dart';
import 'package:arcade_cashier/src/features/sessions/presentation/widgets/session_timer_widget.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActiveSessionDialog extends ConsumerStatefulWidget {
  const ActiveSessionDialog({super.key, this.room, this.session})
    : assert(room != null || session != null);

  final Room? room;
  final Session? session;

  @override
  ConsumerState<ActiveSessionDialog> createState() =>
      _ActiveSessionDialogState();
}

class _ActiveSessionDialogState extends ConsumerState<ActiveSessionDialog> {
  // Timer logic moved to SessionTimerWidget
  final FocusNode _productGridFocusNode = FocusNode();

  @override
  void dispose() {
    _productGridFocusNode.dispose();
    super.dispose();
  }

  Future<void> _showExtendDialog(BuildContext context, int sessionId) async {
    final loc = AppLocalizations.of(context)!;
    return showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(loc.extendTime),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                spacing: 8,
                children: [15, 30, 60]
                    .map(
                      (mins) => ActionChip(
                        label: Text('+$mins ${loc.minutes}'),
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          ref
                              .read(sessionsControllerProvider.notifier)
                              .extendSession(
                                sessionId: sessionId,
                                additionalMinutes: mins,
                              );
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(loc.cancel),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showCompleteSessionDialog({
    required BuildContext context,
    required Session session,
    required List<Order> orders,
    required SessionBill initialBill,
  }) async {
    final loc = AppLocalizations.of(context)!;
    final discountController = TextEditingController();

    // Variable to hold the bill as it gets recalculated
    SessionBill currentBill = initialBill;
    Customer? selectedCustomer;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (sbContext, setState) {
            void updateBill() {
              final discountInput =
                  double.tryParse(discountController.text) ?? 0.0;

              // Recalculate bill using the service logic
              final billingService = ref.read(billingServiceProvider);
              final newBill = billingService.calculateSessionBill(
                session,
                orders,
                discountPercentage: discountInput.clamp(0.0, 100.0),
              );

              setState(() {
                currentBill = newBill;
              });
            }

            return AlertDialog(
              title: Text(loc.completeSession),
              content: SizedBox(
                width: 600, // Wider dialog for better layout
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Section 1: Customer Selection
                      Text(
                        'Customer', // Localize if possible, or use "Customer"
                        style: Theme.of(sbContext).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      CustomerSelectionWidget(
                        onCustomerSelected: (customer) {
                          setState(() {
                            selectedCustomer = customer;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 16),

                      // Section 2: Financials
                      Text(
                        'Payment Details', // Localize
                        style: Theme.of(sbContext).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      // Summary Rows
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal:'),
                          Text(
                            '${currentBill.subtotal.toStringAsFixed(2)} EGP',
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Discount Input
                      TextField(
                        controller: discountController,
                        decoration: const InputDecoration(
                          labelText: 'Discount (%)',
                          border: OutlineInputBorder(),
                          prefixText: '% ',
                          suffixText: '',
                          isDense: true,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'),
                          ),
                        ],
                        onChanged: (_) => updateBill(),
                      ),
                      if (currentBill.discountAmount > 0)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Discount: - ${currentBill.discountAmount.toStringAsFixed(2)} EGP',
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),

                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 12),

                      // Final Total
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            loc.total,
                            style: Theme.of(sbContext).textTheme.titleLarge,
                          ),
                          Text(
                            '${currentBill.totalAmount.toStringAsFixed(2)} EGP',
                            style: Theme.of(sbContext).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(sbContext).primaryColor,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext), // Just close
                  child: Text(loc.cancel),
                ),
                FilledButton(
                  onPressed: () async {
                    Navigator.pop(dialogContext); // Close dialog

                    // Proceed with completion using the FINAL currentBill
                    final result = await ref
                        .read(sessionCompletionControllerProvider.notifier)
                        .completeSession(
                          session: session,
                          roomId: widget.room?.id,
                          orders: orders,
                          bill: currentBill,
                          customer: selectedCustomer,
                        );

                    if (result != null && context.mounted) {
                      Navigator.of(context).pop(); // Close ActiveSessionDialog
                      showDialog(
                        context: context,
                        builder: (_) => InvoicePreviewDialog(
                          pdfBytes: result.pdfBytes,
                          invoice: result.invoice,
                        ),
                      );
                    }
                  },
                  child: Text(loc.finishAndPrint),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    ref.listen<AsyncValue>(sessionCompletionControllerProvider, (_, state) {
      if (state.hasError && !state.isLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(loc.errorMessage(state.error.toString()))),
        );
      }
    });

    ref.listen<AsyncValue>(sessionOrdersControllerProvider, (_, state) {
      if (state.hasError && !state.isLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(loc.errorMessage(state.error.toString()))),
        );
      }
    });

    final sessionAsync = widget.room != null
        ? ref.watch(activeSessionProvider(widget.room!.id))
        : ref.watch(sessionByIdProvider(widget.session!.id));

    final completionState = ref.watch(sessionCompletionControllerProvider);

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.escape): () {
          Navigator.of(context).pop();
        },
        const SingleActivator(LogicalKeyboardKey.enter): () {
          _productGridFocusNode.requestFocus();
        },
        const SingleActivator(LogicalKeyboardKey.keyS, control: true): () {
          if (completionState.isLoading) return;
          sessionAsync.whenData((session) {
            if (session == null) return;
            final ordersAsync = ref.read(sessionOrdersProvider(session.id));
            final orders = ordersAsync.valueOrNull ?? [];
            final billingService = ref.read(billingServiceProvider);
            final bill = billingService.calculateSessionBill(session, orders);
            _showCompleteSessionDialog(
              context: context,
              session: session,
              orders: orders,
              initialBill: bill,
            );
          });
        },
      },
      child: AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        title: Text(
          '${loc.activeSession} - ${widget.session?.isQuickOrder == true ? 'Quick Order' : widget.room?.name ?? 'Unknown'}',
        ),
        content: SizedBox(
          width: 1000,
          height: 600,
          child: sessionAsync.when(
            data: (session) {
              if (session == null) {
                return Center(child: Text(loc.noActiveSessionFound));
              }

              // Orders
              final ordersAsync = ref.watch(sessionOrdersProvider(session.id));
              final ordersList = ordersAsync.valueOrNull ?? [];

              // Calculate Bill
              final billingService = ref.watch(billingServiceProvider);
              final bill = billingService.calculateSessionBill(
                session,
                ordersList,
              );

              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // PRODUCT SELECTION (Left)
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          loc.products,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Card(
                            child: ProductSelectionGrid(
                              sessionId: session.id,
                              focusNode: _productGridFocusNode,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  const VerticalDivider(width: 1),
                  const SizedBox(width: 16),
                  // SESSION INFO & ORDERS (Right)
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        if (!session.isQuickOrder) ...[
                          SessionTimerWidget(
                            session: session,
                            onExtend: () =>
                                _showExtendDialog(context, session.id),
                          ),
                          const Divider(),
                        ],
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                loc.orders,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Expanded(
                                child: SessionOrderList(
                                  ordersAsync: ordersAsync,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        _BillSection(
                          timeCost: bill.timeCost,
                          ordersTotal: bill.ordersTotal,
                          grandTotal: bill.totalAmount,
                          loc: loc,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            error: (e, st) =>
                Center(child: Text(loc.errorMessage(e.toString()))),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ),
        actions: [
          sessionAsync.maybeWhen(
            data: (session) {
              if (session == null) return const SizedBox.shrink();

              final ordersAsync = ref.watch(sessionOrdersProvider(session.id));
              final orders = ordersAsync.valueOrNull ?? [];
              final billingService = ref.watch(billingServiceProvider);
              final bill = billingService.calculateSessionBill(session, orders);

              return SessionActionButtons(
                onCancel: () => Navigator.of(context).pop(),
                onCheckout: () => _showCompleteSessionDialog(
                  context: context,
                  session: session,
                  orders: orders,
                  initialBill: bill,
                ),
                isCheckoutLoading: completionState.isLoading,
                isQuickOrder: session.isQuickOrder,
                isPaused: session.status == SessionStatus.paused,
                onTogglePause: () {
                  if (session.status == SessionStatus.paused) {
                    ref
                        .read(sessionsControllerProvider.notifier)
                        .resumeSession(session.id, session.roomId);
                  } else {
                    ref
                        .read(sessionsControllerProvider.notifier)
                        .pauseSession(session.id, session.roomId);
                  }
                },
              );
            },
            orElse: () => TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(loc.cancel),
            ),
          ),
        ],
      ),
    );
  }
}

class _BillSection extends StatelessWidget {
  final double timeCost;
  final double ordersTotal;
  final double grandTotal;
  final AppLocalizations loc;

  const _BillSection({
    required this.timeCost,
    required this.ordersTotal,
    required this.grandTotal,
    required this.loc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(loc.timeCost),
              Text('${timeCost.toStringAsFixed(2)} EGP'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(loc.orders),
              Text('${ordersTotal.toStringAsFixed(2)} EGP'),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(loc.total, style: Theme.of(context).textTheme.titleLarge),
              Text(
                '${grandTotal.toStringAsFixed(2)} EGP',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
