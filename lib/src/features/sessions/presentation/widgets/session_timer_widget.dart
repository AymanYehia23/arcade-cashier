import 'dart:async';

import 'package:arcade_cashier/src/features/sessions/domain/match_type.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session_type.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';

class SessionTimerWidget extends StatefulWidget {
  final Session session;
  final VoidCallback onExtend;

  const SessionTimerWidget({
    super.key,
    required this.session,
    required this.onExtend,
  });

  @override
  State<SessionTimerWidget> createState() => _SessionTimerWidgetState();
}

class _SessionTimerWidgetState extends State<SessionTimerWidget> {
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

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final startTimeLocal = widget.session.startTime.toLocal();

    String displayTimeText;
    Color? displayTimeColor;

    if (widget.session.status == SessionStatus.paused) {
      displayTimeText = loc.paused; // 'PAUSED'
      displayTimeColor = Colors.grey;
    } else if (widget.session.isQuickOrder) {
      displayTimeText = loc.quickOrder;
      displayTimeColor = Colors.blue;
    } else if (widget.session.sessionType == SessionType.open) {
      final totalPaused = Duration(
        seconds: widget.session.totalPausedDurationSeconds,
      );

      // If currently paused, elapsed time is fixed at (pausedAt - startTime - prePausedDuration)
      // Or simpler: active duration = (pausedAt ?? now) - startTime - totalPausedDuration

      final endPoint = widget.session.pausedAt ?? now;
      final elapsed = endPoint.difference(startTimeLocal) - totalPaused;

      displayTimeText = _formatDuration(elapsed);
      displayTimeColor = Colors.green;
    } else {
      final planned = Duration(
        minutes: widget.session.plannedDurationMinutes ?? 0,
      );
      final endTime = startTimeLocal.add(planned);
      final remaining = endTime.difference(now);

      if (remaining.isNegative) {
        displayTimeText = "${loc.timeUp} -${_formatDuration(remaining.abs())}";
        displayTimeColor = Theme.of(context).colorScheme.error;
      } else {
        displayTimeText = loc.remainingTime(_formatDuration(remaining));
        displayTimeColor = Colors.orange;
      }
    }

    return Column(
      children: [
        Text(loc.timeElapsed, style: Theme.of(context).textTheme.bodyLarge),
        Text(
          displayTimeText,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: displayTimeColor,
            fontWeight: FontWeight.bold,
            fontFeatures: [const FontFeature.tabularFigures()],
            fontSize: 24,
          ),
        ),
        if (widget.session.sessionType == SessionType.fixed)
          TextButton(onPressed: widget.onExtend, child: Text(loc.extendTime)),
        Text(
          '${loc.rateLabel}: ${widget.session.appliedHourlyRate} ${loc.egp}${loc.perHour}',
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Chip(
              label: Text(
                widget.session.matchType == MatchType.single
                    ? loc.singleMatch
                    : widget.session.matchType == MatchType.multi
                        ? loc.multiMatch
                        : loc.other,
              ),
            ),
            const SizedBox(width: 8),
            Chip(
              label: Text(
                widget.session.sessionType == SessionType.open
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
