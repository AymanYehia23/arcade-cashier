import 'package:arcade_cashier/src/common_widgets/error_state_widget.dart';
import 'package:arcade_cashier/src/constants/app_routes.dart';
import 'package:arcade_cashier/src/features/reports/presentation/shift_report_dialog.dart';
import 'package:arcade_cashier/src/features/rooms/domain/room.dart';
import 'package:arcade_cashier/src/features/rooms/presentation/room_card.dart';
import 'package:arcade_cashier/src/features/rooms/presentation/rooms_controller.dart';
import 'package:arcade_cashier/src/features/sessions/presentation/sessions_controller.dart';
import 'package:arcade_cashier/src/features/sessions/presentation/active_session_dialog.dart';
import 'package:arcade_cashier/src/features/sessions/presentation/start_session_dialog.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.dashboardTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.assessment),
            onPressed: () => ShiftReportDialog.show(context),
            tooltip: loc.endShift,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push(AppRoutes.settings),
          ),
        ],
      ),
      body: roomsWithSessionsValue.when(
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
                          builder: (context) => StartSessionDialog(room: room),
                        );
                      } else if (isOccupied ||
                          room.currentStatus == RoomStatus.occupied) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => ActiveSessionDialog(room: room),
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
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final session = await ref
              .read(sessionsControllerProvider.notifier)
              .startSession(
                roomId: null,
                rate:
                    0.0, // Free for walk-ins? Or standard rate? User said "time is free/irrelevant".
                isMultiMatch: false,
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
    );
  }
}
