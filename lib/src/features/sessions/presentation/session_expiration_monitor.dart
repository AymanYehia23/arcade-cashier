import 'dart:async';

import 'package:arcade_cashier/src/features/rooms/presentation/rooms_controller.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session_type.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that monitors all active sessions in the background and
/// triggers an alert when a fixed-duration session expires.
///
/// Wrap this widget around the main dashboard content to enable
/// global session expiration monitoring.
class SessionExpirationMonitor extends ConsumerStatefulWidget {
  final Widget child;

  const SessionExpirationMonitor({super.key, required this.child});

  @override
  ConsumerState<SessionExpirationMonitor> createState() =>
      _SessionExpirationMonitorState();
}

class _SessionExpirationMonitorState
    extends ConsumerState<SessionExpirationMonitor> {
  Timer? _timer;
  final Set<int> _alertedSessionIds = {};
  AudioPlayer? _audioPlayer;
  bool _isDialogShowing = false;

  @override
  void initState() {
    super.initState();
    _startMonitoring();
  }

  void _startMonitoring() {
    // Check every 5 seconds for expired sessions
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      _checkExpiredSessions();
    });
  }

  void _checkExpiredSessions() {
    // Don't check if a dialog is already showing
    if (_isDialogShowing) return;

    final roomsWithSessionsAsync = ref.read(roomsWithSessionsProvider);

    roomsWithSessionsAsync.whenData((roomsWithSessions) {
      final now = DateTime.now();

      for (final roomWithSession in roomsWithSessions) {
        final session = roomWithSession.activeSession;
        if (session == null) continue;

        // Only check fixed-duration sessions
        if (session.sessionType != SessionType.fixed) continue;
        if (session.plannedDurationMinutes == null) continue;
        if (session.status == SessionStatus.paused) continue;

        // Check if already alerted
        if (_alertedSessionIds.contains(session.id)) continue;

        // Calculate expiration time
        final startTimeLocal = session.startTime.toLocal();
        final planned = Duration(minutes: session.plannedDurationMinutes!);
        final expirationTime = startTimeLocal.add(planned);

        // If expired, trigger alert
        if (now.isAfter(expirationTime)) {
          _alertedSessionIds.add(session.id);
          _playAlarmSound();
          _showTimeUpDialog(roomWithSession.room.name);
          break; // Only show one alert at a time
        }
      }
    });
  }

  Future<void> _playAlarmSound() async {
    _audioPlayer = AudioPlayer();
    await _audioPlayer!.play(AssetSource('sounds/alarm.mp3'));
    _audioPlayer!.setReleaseMode(ReleaseMode.loop);
  }

  void _stopAlarmSound() {
    _audioPlayer?.stop();
    _audioPlayer?.dispose();
    _audioPlayer = null;
  }

  void _showTimeUpDialog(String roomName) {
    if (!mounted) return;

    _isDialogShowing = true;
    final loc = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          loc.timeUpAlertTitle(roomName),
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
        content: Text(loc.timeUpAlertContent),
        actions: [
          FilledButton(
            onPressed: () {
              _stopAlarmSound();
              Navigator.pop(dialogContext);
            },
            child: Text(loc.dismiss),
          ),
        ],
      ),
    ).then((_) {
      _isDialogShowing = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _stopAlarmSound();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
