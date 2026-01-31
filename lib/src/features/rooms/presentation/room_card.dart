import 'package:arcade_cashier/src/features/rooms/domain/room.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({
    super.key,
    required this.room,
    required this.onStatusChanged,
  });

  final Room room;
  final ValueChanged<RoomStatus> onStatusChanged;

  Color _getStatusColor(RoomStatus status) {
    switch (status) {
      case RoomStatus.available:
        return Colors.green.shade100;
      case RoomStatus.occupied:
        return Colors.red.shade100;
      case RoomStatus.maintenance:
        return Colors.grey.shade300;
      case RoomStatus.held:
        return Colors.orange.shade100;
    }
  }

  Color _getStatusTextColor(RoomStatus status) {
    switch (status) {
      case RoomStatus.available:
        return Colors.green.shade900;
      case RoomStatus.occupied:
        return Colors.red.shade900;
      case RoomStatus.maintenance:
        return Colors.grey.shade800;
      case RoomStatus.held:
        return Colors.orange.shade900;
    }
  }

  String _getStatusText(BuildContext context, RoomStatus status) {
    final loc = AppLocalizations.of(context)!;
    switch (status) {
      case RoomStatus.available:
        return loc.statusAvailable;
      case RoomStatus.occupied:
        return loc.statusOccupied;
      case RoomStatus.maintenance:
        return loc.statusMaintenance;
      case RoomStatus.held:
        return loc.statusHeld;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(room.currentStatus);
    final textColor = _getStatusTextColor(room.currentStatus);

    return Card(
      color: statusColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // Toggle status logic
          final newStatus = room.currentStatus == RoomStatus.available
              ? RoomStatus.occupied
              : RoomStatus.available;
          onStatusChanged(newStatus);
        },
        child: Stack(
          children: [
            Positioned(
              top: 12,
              right: 12,
              child: Icon(
                Icons.videogame_asset,
                size: 48,
                color: textColor.withValues(alpha: 0.2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 24),
                  Center(
                    child: Text(
                      room.name,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Chip(
                            label: Text(
                              room.deviceType.displayTitle,
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: Colors.white.withValues(
                              alpha: 0.5,
                            ),
                            side: BorderSide.none,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Center(
                        child: Text(
                          '${room.singleMatchHourlyRate} / ${room.multiMatchHourlyRate} EGP',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: textColor,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Center(
                        child: Text(
                          _getStatusText(context, room.currentStatus),
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(color: textColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
