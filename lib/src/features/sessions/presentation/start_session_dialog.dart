import 'package:arcade_cashier/src/features/rooms/domain/room.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session_type.dart';
import 'package:arcade_cashier/src/features/sessions/presentation/sessions_controller.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:arcade_cashier/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartSessionDialog extends ConsumerStatefulWidget {
  const StartSessionDialog({super.key, required this.room});

  final Room room;

  @override
  ConsumerState<StartSessionDialog> createState() => _StartSessionDialogState();
}

class _StartSessionDialogState extends ConsumerState<StartSessionDialog> {
  SessionType _selectedType = SessionType.open;
  int? _selectedDuration;

  final List<int> _durations = [30, 60, 120, 180];

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(sessionsControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
      if (!state.isLoading && !state.hasError) {
        Navigator.of(context).pop();
      }
    });

    final loc = AppLocalizations.of(context)!;
    final state = ref.watch(sessionsControllerProvider);

    return AlertDialog(
      title: Text('${loc.startSession} - ${widget.room.name}'),
      content: state.isLoading
          ? const SizedBox(
              height: 150,
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SegmentedButton<SessionType>(
                    segments: [
                      ButtonSegment(
                        value: SessionType.open,
                        label: Text(loc.openTime),
                        icon: const Icon(Icons.timer_off),
                      ),
                      ButtonSegment(
                        value: SessionType.fixed,
                        label: Text(loc.fixedTime),
                        icon: const Icon(Icons.timer),
                      ),
                    ],
                    selected: {_selectedType},
                    onSelectionChanged: (newSelection) {
                      setState(() {
                        _selectedType = newSelection.first;
                        if (_selectedType == SessionType.fixed &&
                            _selectedDuration == null) {
                          _selectedDuration = 60;
                        }
                      });
                    },
                  ),
                  if (_selectedType == SessionType.fixed) ...[
                    const SizedBox(height: 16),
                    Text(
                      loc.duration,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _durations.map((minutes) {
                        return ChoiceChip(
                          label: Text('$minutes ${loc.minutes}'),
                          selected: _selectedDuration == minutes,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() => _selectedDuration = minutes);
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ],
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 50,
                    child: FilledButton(
                      onPressed: () {
                        ref
                            .read(sessionsControllerProvider.notifier)
                            .startSession(
                              roomId: widget.room.id,
                              rate: widget.room.singleMatchHourlyRate,
                              isMultiMatch: false,
                              sessionType: _selectedType,
                              plannedDurationMinutes:
                                  _selectedType == SessionType.fixed
                                  ? _selectedDuration
                                  : null,
                            );
                      },
                      child: Text(
                        '${loc.singleMatch} (2P) - ${widget.room.singleMatchHourlyRate} EGP/hr',
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 50,
                    child: FilledButton.tonal(
                      onPressed: () {
                        ref
                            .read(sessionsControllerProvider.notifier)
                            .startSession(
                              roomId: widget.room.id,
                              rate: widget.room.multiMatchHourlyRate,
                              isMultiMatch: true,
                              sessionType: _selectedType,
                              plannedDurationMinutes:
                                  _selectedType == SessionType.fixed
                                  ? _selectedDuration
                                  : null,
                            );
                      },
                      child: Text(
                        '${loc.multiMatch} (4P) - ${widget.room.multiMatchHourlyRate} EGP/hr',
                      ),
                    ),
                  ),
                ],
              ),
            ),
      actions: [
        if (!state.isLoading)
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(loc.cancel),
          ),
      ],
    );
  }
}
