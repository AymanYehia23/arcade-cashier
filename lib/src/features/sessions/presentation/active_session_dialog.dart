import 'dart:async';

import 'package:arcade_cashier/src/features/invoices/presentation/invoice_preview_dialog.dart';
import 'package:arcade_cashier/src/features/invoices/presentation/session_completion_controller.dart';
import 'package:arcade_cashier/src/features/orders/domain/order.dart';
import 'package:arcade_cashier/src/features/orders/presentation/product_selection_grid.dart';
import 'package:arcade_cashier/src/features/orders/presentation/session_orders_controller.dart';
import 'package:arcade_cashier/src/features/rooms/domain/room.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session_type.dart';
import 'package:arcade_cashier/src/features/sessions/presentation/sessions_controller.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActiveSessionDialog extends ConsumerStatefulWidget {
  const ActiveSessionDialog({super.key, required this.room});

  final Room room;

  @override
  ConsumerState<ActiveSessionDialog> createState() =>
      _ActiveSessionDialogState();
}

class _ActiveSessionDialogState extends ConsumerState<ActiveSessionDialog> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          // Trigger rebuild to update time
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
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
    required double timeCost,
    required double grandTotal,
  }) async {
    final loc = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(loc.completeSession),
          content: Text(loc.totalBillAmount(grandTotal.toStringAsFixed(2))),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(loc.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(loc.finishAndPrint),
            ),
          ],
        );
      },
    );

    if (confirmed == true && context.mounted) {
      final result = await ref
          .read(sessionCompletionControllerProvider.notifier)
          .completeSession(
            session: session,
            roomId: widget.room.id,
            orders: orders,
            timeCost: timeCost,
            totalAmount: grandTotal,
          );

      if (result != null && context.mounted) {
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (_) => InvoicePreviewDialog(
            pdfBytes: result.pdfBytes,
            invoiceNumber: result.invoice.invoiceNumber,
          ),
        );
      }
    }
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

    final sessionAsync = ref.watch(activeSessionProvider(widget.room.id));
    final completionState = ref.watch(sessionCompletionControllerProvider);

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      title: Text('${loc.activeSession} - ${widget.room.name}'),
      content: SizedBox(
        width: 1000,
        height: 600,
        child: sessionAsync.when(
          data: (session) {
            if (session == null) {
              return Center(child: Text(loc.noActiveSessionFound));
            }

            final now = DateTime.now();
            final startTimeLocal = session.startTime.toLocal();
            String timeText = '';
            Color? timeColor;
            double timeCost = 0.0;

            if (session.sessionType == SessionType.open) {
              final elapsed = now.difference(startTimeLocal);
              timeText = _formatDuration(elapsed);
              timeColor = Colors.green;

              final hours = elapsed.inMinutes / 60.0;
              timeCost = hours * session.appliedHourlyRate;
            } else {
              final planned = Duration(
                minutes: session.plannedDurationMinutes ?? 0,
              );
              final endTime = startTimeLocal.add(planned);
              final remaining = endTime.difference(now);

              if (remaining.isNegative) {
                timeText = "${loc.timeUp} -${_formatDuration(remaining.abs())}";
                timeColor = Theme.of(context).colorScheme.error;
              } else {
                timeText = "${_formatDuration(remaining)} remaining";
                timeColor = Colors.orange;
              }

              final plannedHours = (session.plannedDurationMinutes ?? 0) / 60.0;
              timeCost = plannedHours * session.appliedHourlyRate;
            }

            // Orders
            final ordersAsync = ref.watch(sessionOrdersProvider(session.id));
            double ordersTotal = 0;
            List<Order> ordersList = [];
            if (ordersAsync.hasValue) {
              ordersList = ordersAsync.value!;
              ordersTotal = ordersList.fold(0, (sum, x) => sum + x.totalPrice);
            }

            final grandTotal = timeCost + ordersTotal;

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
                          child: ProductSelectionGrid(sessionId: session.id),
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
                      _SessionInfoSection(
                        timeText: timeText,
                        timeColor: timeColor,
                        session: session,
                        loc: loc,
                        onExtend: () => _showExtendDialog(context, session.id),
                      ),
                      const Divider(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              loc.orders,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Expanded(
                              child: _OrdersList(ordersAsync: ordersAsync),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      _BillSection(
                        timeCost: timeCost,
                        ordersTotal: ordersTotal,
                        grandTotal: grandTotal,
                        loc: loc,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          error: (e, st) => Center(child: Text(loc.errorMessage(e.toString()))),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
      actions: [
        if (!completionState.isLoading) ...[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(loc.cancel),
          ),
          sessionAsync.maybeWhen(
            data: (session) {
              if (session == null) return const SizedBox.shrink();

              final ordersAsync = ref.watch(sessionOrdersProvider(session.id));
              final orders = ordersAsync.valueOrNull ?? [];

              // Calculate costs
              double timeCost = 0.0;
              if (session.sessionType == SessionType.open) {
                final elapsed = DateTime.now().difference(
                  session.startTime.toLocal(),
                );
                final hours = elapsed.inMinutes / 60.0;
                timeCost = hours * session.appliedHourlyRate;
              } else {
                final plannedHours =
                    (session.plannedDurationMinutes ?? 0) / 60.0;
                timeCost = plannedHours * session.appliedHourlyRate;
              }

              final ordersTotal = orders.fold(
                0.0,
                (sum, x) => sum + x.totalPrice,
              );
              final grandTotal = timeCost + ordersTotal;

              return FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () => _showCompleteSessionDialog(
                  context: context,
                  session: session,
                  orders: orders,
                  timeCost: timeCost,
                  grandTotal: grandTotal,
                ),
                child: Text(loc.stopSession),
              );
            },
            orElse: () => const SizedBox.shrink(),
          ),
        ] else
          const CircularProgressIndicator(),
      ],
    );
  }
}

class _SessionInfoSection extends StatelessWidget {
  final String timeText;
  final Color? timeColor;
  final Session session;
  final AppLocalizations loc;
  final VoidCallback onExtend;

  const _SessionInfoSection({
    required this.timeText,
    required this.timeColor,
    required this.session,
    required this.loc,
    required this.onExtend,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(loc.timeElapsed, style: Theme.of(context).textTheme.bodyLarge),
        Text(
          timeText,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: timeColor,
            fontWeight: FontWeight.bold,
            fontFeatures: [const FontFeature.tabularFigures()],
            fontSize: 24, // Reduced font size for better fit
          ),
        ),
        if (session.sessionType == SessionType.fixed)
          TextButton(onPressed: onExtend, child: Text(loc.extendTime)),
        Text('Rate: ${session.appliedHourlyRate} EGP/hr'),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (session.isMultiMatch)
              Chip(label: Text(loc.multiMatch))
            else
              Chip(label: Text(loc.singleMatch)),
            const SizedBox(width: 8),
            Chip(
              label: Text(
                session.sessionType == SessionType.open
                    ? loc.openTime
                    : loc.fixedTime,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _OrdersList extends ConsumerWidget {
  final AsyncValue<List<Order>> ordersAsync;

  const _OrdersList({required this.ordersAsync});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ordersAsync.when(
      data: (orders) {
        if (orders.isEmpty) return const Center(child: Text('No orders yet'));
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
      error: (e, s) => Center(child: Text('Error loading orders')),
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
