import 'package:arcade_cashier/src/features/tables/domain/cafe_table.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TableCard extends ConsumerStatefulWidget {
  const TableCard({
    super.key,
    required this.table,
    required this.onTap,
    this.activeSession,
  });

  final CafeTable table;
  final VoidCallback onTap;
  final Session? activeSession;

  @override
  ConsumerState<TableCard> createState() => _TableCardState();
}

class _TableCardState extends ConsumerState<TableCard> {
  bool _isHovered = false;

  Color _getStatusTextColor(TableStatus status) {
    switch (status) {
      case TableStatus.available:
        return const Color(0xFF39FF14); // Neon Green
      case TableStatus.occupied:
        return const Color(0xFFFF0033); // Bright Red
      case TableStatus.maintenance:
        return Colors.grey;
    }
  }

  String _getStatusText(BuildContext context, TableStatus status) {
    final loc = AppLocalizations.of(context)!;
    switch (status) {
      case TableStatus.available:
        return loc.statusAvailable;
      case TableStatus.occupied:
        return loc.statusOccupied;
      case TableStatus.maintenance:
        return loc.statusMaintenance;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = Theme.of(context).cardColor;
    final textColor = _getStatusTextColor(widget.table.currentStatus);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Card(
          elevation: _isHovered ? 8 : 2,
          color: statusColor,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon and Table Name
                  Row(
                    children: [
                      Icon(
                        Icons.table_restaurant,
                        size: 32,
                        color: textColor,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.table.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Table Number (if available)
                  if (widget.table.tableNumber != null) ...[
                    Text(
                      '${AppLocalizations.of(context)!.tableNumber}: ${widget.table.tableNumber}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade400,
                          ),
                    ),
                    const SizedBox(height: 8),
                  ],

                  const Spacer(),

                  // Status Chip
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: textColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: textColor, width: 1),
                    ),
                    child: Text(
                      _getStatusText(context, widget.table.currentStatus),
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  // Orders indicator (if table is occupied)
                  if (widget.activeSession != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.receipt,
                          size: 16,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          AppLocalizations.of(context)!.ordersOnly,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey.shade400,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
