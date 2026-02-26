import 'package:arcade_cashier/src/common_widgets/error_state_widget.dart';
import 'package:arcade_cashier/src/common_widgets/logo_loading_indicator.dart';
import 'package:arcade_cashier/src/constants/app_routes.dart';
import 'package:arcade_cashier/src/features/reports/presentation/shift_report_dialog.dart';
import 'package:arcade_cashier/src/features/shifts/data/shift_repository.dart';
import 'package:arcade_cashier/src/features/shifts/presentation/end_shift_dialog.dart';
import 'package:arcade_cashier/src/features/rooms/domain/room.dart';
import 'package:arcade_cashier/src/features/rooms/presentation/room_card.dart';
import 'package:arcade_cashier/src/features/rooms/presentation/rooms_controller.dart';
import 'package:arcade_cashier/src/features/sessions/presentation/session_expiration_monitor.dart';
import 'package:arcade_cashier/src/features/sessions/presentation/sessions_controller.dart';
import 'package:arcade_cashier/src/features/sessions/presentation/active_session_dialog.dart';
import 'package:arcade_cashier/src/features/sessions/presentation/start_session_dialog.dart';
import 'package:arcade_cashier/src/features/sessions/domain/match_type.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session_type.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:arcade_cashier/src/utils/async_value_ui.dart';
import 'package:arcade_cashier/src/utils/error_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      roomsControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    ref.listen<AsyncValue>(
      sessionsControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final roomsWithSessionsValue = ref.watch(roomsWithSessionsProvider);
    final loc = AppLocalizations.of(context)!;

    return SessionExpirationMonitor(
      child: Scaffold(
        appBar: AppBar(
          title: Text(loc.dashboardTitle),
          actions: [
            // Current shift / cashier chip
            Consumer(
              builder: (context, ref, _) {
                final shiftAsync = ref.watch(currentShiftProvider);
                return shiftAsync.maybeWhen(
                  data: (shift) {
                    if (shift == null) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ActionChip(
                        avatar: const Icon(Icons.person, size: 18),
                        label: Text(
                          shift.cashierName ?? loc.unknown,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        onPressed: () => EndShiftDialog.show(context, shift),
                      ),
                    );
                  },
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.assessment),
              onPressed: () => ShiftReportDialog.show(context),
              tooltip: loc.endOfShiftReport,
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => context.push(AppRoutes.settings),
            ),
          ],
        ),
        body: roomsWithSessionsValue.when(
          // Skip showing error during initial stream connection to prevent
          // a brief "Something Went Wrong" flash on app startup.
          skipError: true,
          data: (roomsWithSessions) {
            if (roomsWithSessions.isEmpty) {
              return Center(child: Text(loc.noRoomsFound));
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
                return GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: roomsWithSessions.length,
                  itemBuilder: (context, index) {
                    final roomWithSession = roomsWithSessions[index];
                    final room = roomWithSession.room;
                    final activeSession = roomWithSession.activeSession;
                    // Derive occupancy from active session presence
                    final isOccupied = activeSession != null;

                    return RoomCard(
                      room: room,
                      activeSession: activeSession,
                      onTap: () {
                        if (!isOccupied &&
                            room.currentStatus == RoomStatus.available) {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                StartSessionDialog(room: room),
                          );
                        } else if (isOccupied ||
                            room.currentStatus == RoomStatus.occupied) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) =>
                                ActiveSessionDialog(room: room),
                          );
                        }
                      },
                    );
                  },
                );
              },
            );
          },
          error: (e, st) => ErrorStateWidget(
            message: getUserFriendlyErrorMessage(e, context),
            onRetry: () => ref.invalidate(roomsWithSessionsProvider),
          ),
          loading: () => const Center(child: LogoLoadingIndicator()),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            final session = await ref
                .read(sessionsControllerProvider.notifier)
                .startSession(
                  roomId: null,
                  rate:
                      0.0, // Free for walk-ins? Or standard rate? User said "time is free/irrelevant".
                  matchType: MatchType.single,
                  sessionType: SessionType.open,
                );

            if (context.mounted && session != null) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => ActiveSessionDialog(session: session),
              );
            }
          },
          label: Text(loc.quickOrder),
          icon: const Icon(Icons.flash_on),
        ),
      ),
    );
  }
}
