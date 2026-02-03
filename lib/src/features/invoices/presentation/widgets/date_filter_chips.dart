import 'package:arcade_cashier/src/features/invoices/presentation/invoices_search_controller.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateFilterChips extends ConsumerWidget {
  const DateFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRange = ref.watch(invoiceDateRangeProvider);
    final loc = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _FilterChip(
            label: loc.filterToday,
            isSelected: _isToday(currentRange),
            onSelected: () {
              final now = DateTime.now();
              final start = DateTime(now.year, now.month, now.day);
              final end = start
                  .add(const Duration(days: 1))
                  .subtract(const Duration(milliseconds: 1));
              ref
                  .read(invoiceDateRangeProvider.notifier)
                  .setRange(DateTimeRange(start: start, end: end));
            },
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: loc.filterThisMonth,
            isSelected: _isThisMonth(currentRange),
            onSelected: () {
              final now = DateTime.now();
              final start = DateTime(now.year, now.month, 1);
              final end = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
              ref
                  .read(invoiceDateRangeProvider.notifier)
                  .setRange(DateTimeRange(start: start, end: end));
            },
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: loc.filterLast3Months,
            isSelected: _isLast3Months(currentRange),
            onSelected: () {
              final now = DateTime.now();
              // Current month is included? "Last 3 months" usually means (current - 2) -> current end.
              // e.g. If Oct, last 3 months = Aug, Sep, Oct.
              final start = DateTime(now.year, now.month - 2, 1);
              final end = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
              ref
                  .read(invoiceDateRangeProvider.notifier)
                  .setRange(DateTimeRange(start: start, end: end));
            },
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: loc.filterThisYear,
            isSelected: _isThisYear(currentRange),
            onSelected: () {
              final now = DateTime.now();
              final start = DateTime(now.year, 1, 1);
              final end = DateTime(now.year, 12, 31, 23, 59, 59);
              ref
                  .read(invoiceDateRangeProvider.notifier)
                  .setRange(DateTimeRange(start: start, end: end));
            },
          ),
        ],
      ),
    );
  }

  bool _isToday(DateTimeRange? range) {
    if (range == null) return false;
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    // Compare just the start date or range rough equality.
    return range.start.year == start.year &&
        range.start.month == start.month &&
        range.start.day == start.day &&
        range.duration.inDays == 0; // Approx check
  }

  bool _isThisMonth(DateTimeRange? range) {
    if (range == null) return false;
    final now = DateTime.now();
    return range.start.year == now.year &&
        range.start.month == now.month &&
        range.start.day == 1 &&
        range.end.day >= 28; // lenient check for end of month
  }

  bool _isLast3Months(DateTimeRange? range) {
    if (range == null) return false;
    final now = DateTime.now();
    // Simply check if start is roughly 3 months ago
    return range.start.isBefore(DateTime(now.year, now.month - 1)) &&
        range.end.year == now.year &&
        range.end.month == now.month;
  }

  bool _isThisYear(DateTimeRange? range) {
    if (range == null) return false;
    final now = DateTime.now();
    return range.start.year == now.year &&
        range.start.month == 1 &&
        range.start.day == 1;
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      showCheckmark: false,
    );
  }
}
