import 'package:arcade_cashier/src/features/shifts/data/shift_repository.dart';
import 'package:arcade_cashier/src/features/shifts/domain/shift.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Dialog for ending the current shift.
/// Collects cash count data and closes the shift.
class EndShiftDialog extends ConsumerStatefulWidget {
  const EndShiftDialog({super.key, required this.shift});

  final Shift shift;

  static Future<void> show(BuildContext context, Shift shift) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => EndShiftDialog(shift: shift),
    );
  }

  @override
  ConsumerState<EndShiftDialog> createState() => _EndShiftDialogState();
}

class _EndShiftDialogState extends ConsumerState<EndShiftDialog> {
  final _totalCashController = TextEditingController();
  final _cashDroppedController = TextEditingController();
  bool _isEnding = false;

  double get _totalCash => double.tryParse(_totalCashController.text) ?? 0.0;

  double get _cashDropped =>
      double.tryParse(_cashDroppedController.text) ?? 0.0;

  double get _cashLeftInDrawer => _totalCash - _cashDropped;

  @override
  void dispose() {
    _totalCashController.dispose();
    _cashDroppedController.dispose();
    super.dispose();
  }

  Future<void> _endShift() async {
    if (widget.shift.id == null) return;

    setState(() => _isEnding = true);

    try {
      await ref
          .read(shiftRepositoryProvider)
          .endShift(
            shiftId: widget.shift.id!,
            actualEndingCash: _totalCash,
            cashDropped: _cashDropped,
            cashLeftInDrawer: _cashLeftInDrawer,
          );

      if (mounted) {
        Navigator.of(context).pop();
        // Router redirect will automatically lock the app
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
        setState(() => _isEnding = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.endShift,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: _isEnding
                        ? null
                        : () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Shift info
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.person, color: theme.colorScheme.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.shift.cashierName ?? loc.unknown,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (widget.shift.openedAt != null)
                            Text(
                              '${loc.shiftStartedAt} ${_formatTime(widget.shift.openedAt!)}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          loc.startingCashLabel,
                          style: theme.textTheme.bodySmall,
                        ),
                        Text(
                          '${widget.shift.startingCash.toStringAsFixed(2)} ${loc.egp}',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 16),

              // Cash inputs
              Text(loc.countTheDrawer, style: theme.textTheme.titleMedium),
              const SizedBox(height: 16),

              TextField(
                controller: _totalCashController,
                autofocus: true,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  labelText: loc.totalCashCounted,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.payments),
                  suffixText: loc.egp,
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _cashDroppedController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  labelText: loc.cashDroppedToSafe,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.savings),
                  suffixText: loc.egp,
                ),
                onChanged: (_) => setState(() {}),
              ),

              const SizedBox(height: 16),

              // Calculated cash left
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      loc.cashLeftInDrawer,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${_cashLeftInDrawer.toStringAsFixed(2)} ${loc.egp}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _cashLeftInDrawer < 0
                            ? theme.colorScheme.error
                            : null,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isEnding
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: Text(loc.cancel),
                  ),
                  const SizedBox(width: 12),
                  FilledButton.icon(
                    onPressed: _isEnding ? null : _endShift,
                    icon: _isEnding
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.lock),
                    label: Text(loc.endShift),
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.error,
                      foregroundColor: theme.colorScheme.onError,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final local = dt.toLocal();
    return '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  }
}
