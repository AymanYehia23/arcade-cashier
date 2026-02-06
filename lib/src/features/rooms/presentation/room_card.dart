import 'package:arcade_cashier/src/features/rooms/domain/room.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session_type.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomCard extends ConsumerStatefulWidget {
  const RoomCard({
    super.key,
    required this.room,
    required this.onTap,
    this.activeSession,
  });

  final Room room;
  final VoidCallback onTap;
  final Session? activeSession;

  @override
  ConsumerState<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends ConsumerState<RoomCard>
    with SingleTickerProviderStateMixin {
  AnimationController? _pulseController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _pulseController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(RoomCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // The logic for starting/stopping pulse is now in build,
    // so this block is no longer needed.
  }

  Color _getStatusTextColor(RoomStatus status) {
    switch (status) {
      case RoomStatus.available:
        return const Color(0xFF39FF14); // Neon Green
      case RoomStatus.occupied:
        return const Color(0xFFFF0033); // Bright Red
      case RoomStatus.maintenance:
        return Colors.grey;
      case RoomStatus.held:
        return Colors.orangeAccent;
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
    final statusColor = Theme.of(context).cardColor;
    final textColor = _getStatusTextColor(widget.room.currentStatus);
    final pulseColorAnimation = ColorTween(
      begin: statusColor,
      end: Theme.of(context).colorScheme.error.withValues(alpha: 0.5),
    ).animate(_pulseController!);

    // Check for expiration if occupied
    final session = widget.activeSession;
    bool isExpired = false;

    if (session != null && session.sessionType == SessionType.fixed) {
      final startTimeLocal = session.startTime.toLocal();
      final planned = Duration(minutes: session.plannedDurationMinutes ?? 0);
      final end = startTimeLocal.add(planned);
      if (DateTime.now().isAfter(end)) {
        isExpired = true;
      }
    }

    if (isExpired && !_pulseController!.isAnimating) {
      _pulseController!.repeat(reverse: true);
    } else if (!isExpired && _pulseController!.isAnimating) {
      _pulseController!.stop();
      _pulseController!.reset();
    }

    return _buildCard(
      context,
      isExpired ? (pulseColorAnimation.value ?? Colors.red) : statusColor,
      textColor,
      isExpired,
    );
  }

  Widget _buildCard(
    BuildContext context,
    Color? bgColor,
    Color textColor,
    bool isExpired,
  ) {
    final loc = AppLocalizations.of(context)!;
    return AnimatedBuilder(
      animation: _pulseController ?? const AlwaysStoppedAnimation(0),
      builder: (context, child) {
        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: Card(
              color: bgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: _isHovered
                    ? BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      )
                    : BorderSide.none,
              ),
              elevation: _isHovered ? 8 : 4,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: widget.onTap,
                child: Stack(
                  children: [
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Icon(
                        isExpired
                            ? Icons.warning_amber_rounded
                            : Icons.videogame_asset,
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
                              'Room ${widget.room.name}',
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
                              if (isExpired)
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      loc.timeUp,
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Chip(
                                    label: Text(
                                      widget.room.deviceType.displayTitle(
                                        context,
                                      ),
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainerHighest,
                                    side: BorderSide.none,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Center(
                                child: Text(
                                  '${widget.room.singleMatchHourlyRate} / ${widget.room.multiMatchHourlyRate} EGP',
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
                                  _getStatusText(
                                    context,
                                    widget.room.currentStatus,
                                  ),
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(color: textColor),
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
            ),
          ),
        );
      },
    );
  }
}
