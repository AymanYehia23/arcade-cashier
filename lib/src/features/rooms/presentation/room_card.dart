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
    return Card(
      color: _getStatusColor(room.currentStatus),
      child: InkWell(
        onTap: () {
          // TODO: Implement status change dialog or bottom sheet
          // For now, toggle between Available and Occupied for testing
          final newStatus = room.currentStatus == RoomStatus.available
              ? RoomStatus.occupied
              : RoomStatus.available;
          onStatusChanged(newStatus);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                room.name,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                room.deviceType,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Chip(
                label: Text(_getStatusText(context, room.currentStatus)),
                backgroundColor: Colors.white.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
