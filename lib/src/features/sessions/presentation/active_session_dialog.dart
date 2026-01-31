import 'dart:async';

import 'package:arcade_cashier/src/features/rooms/domain/room.dart';
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
  Duration _elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        // We will update this properly once we have the session start time
      });
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

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    ref.listen<AsyncValue>(sessionsControllerProvider, (_, state) {
      state.whenOrNull(
        data: (_) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(loc.sessionStopped)));
        },
        error: (err, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(loc.errorMessage(err.toString()))),
          );
        },
      );
    });

    final sessionAsync = ref.watch(activeSessionProvider(widget.room.id));
    final controllerState = ref.watch(sessionsControllerProvider);

    return AlertDialog(
      title: Text('${loc.activeSession} - ${widget.room.name}'),
      content: sessionAsync.when(
        data: (session) {
          if (session == null) {
            return Text(loc.noActiveSessionFound);
          }

          final now = DateTime.now();
          // Logic for display
          String timeText = '';
          Color? timeColor;

          final startTimeLocal = session.startTime.toLocal();

          if (session.sessionType == SessionType.open) {
            _elapsed = now.difference(startTimeLocal);
            timeText = _formatDuration(_elapsed);
            timeColor = Colors.green;
          } else {
            // Fixed time logic
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
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                loc.timeElapsed,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Text(
                timeText,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: timeColor,
                  fontFeatures: [const FontFeature.tabularFigures()],
                ),
              ),
              const SizedBox(height: 8),
              if (session.sessionType == SessionType.fixed)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: FilterChip(
                    label: Text(loc.extendTime),
                    onSelected: (_) => _showExtendDialog(context, session.id),
                  ),
                ),
              Text(
                'Rate: ${session.appliedHourlyRate} EGP/hr',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
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
        },
        error: (e, st) => Text(loc.errorMessage(e.toString())),
        loading: () => const SizedBox(
          height: 100,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      actions: [
        if (!controllerState.isLoading) ...[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(loc.cancel),
          ),
          sessionAsync.maybeWhen(
            data: (session) => session != null
                ? FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                    onPressed: () {
                      ref
                          .read(sessionsControllerProvider.notifier)
                          .stopSession(
                            sessionId: session.id,
                            roomId: widget.room.id,
                          );
                    },
                    child: Text(loc.stopSession),
                  )
                : const SizedBox.shrink(),
            orElse: () => const SizedBox.shrink(),
          ),
        ] else
          const CircularProgressIndicator(),
      ],
    );
  }
}
