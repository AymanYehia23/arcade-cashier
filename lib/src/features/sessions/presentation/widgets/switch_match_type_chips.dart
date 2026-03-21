import 'package:arcade_cashier/src/features/rooms/domain/room.dart';
import 'package:arcade_cashier/src/features/sessions/domain/match_type.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session.dart';
import 'package:arcade_cashier/src/features/sessions/presentation/sessions_controller.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwitchMatchTypeChips extends ConsumerWidget {
  const SwitchMatchTypeChips({
    super.key,
    required this.session,
    required this.room,
  });

  final Session session;
  final Room room;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final isPaused = session.status == SessionStatus.paused;

    final options = [
      (MatchType.single, loc.singleMatch, room.singleMatchHourlyRate),
      (MatchType.multi, loc.multiMatch, room.multiMatchHourlyRate),
      (MatchType.other, loc.other, room.otherHourlyRate),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(loc.switchMatchType, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          children: options.map((option) {
            final (matchType, label, rate) = option;
            final isActive = session.matchType == matchType;

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Tooltip(
                message: isPaused ? loc.resumeBeforeSwitching : '',
                child: ChoiceChip(
                  label: Text('$label  •  $rate ${loc.egpPerHour}'),
                  selected: isActive,
                  onSelected: isActive || isPaused
                      ? null
                      : (_) {
                          ref
                              .read(sessionsControllerProvider.notifier)
                              .switchMatchType(
                                currentSession: session,
                                newMatchType: matchType,
                                newRate: rate,
                              );
                        },
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
