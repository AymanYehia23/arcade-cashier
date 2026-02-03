import 'package:arcade_cashier/src/constants/app_routes.dart';
import 'package:arcade_cashier/src/features/rooms/data/rooms_repository.dart';
import 'package:arcade_cashier/src/features/rooms/domain/room.dart';
import 'package:arcade_cashier/src/features/rooms/presentation/room_card.dart';
import 'package:arcade_cashier/src/features/rooms/presentation/rooms_controller.dart';
import 'package:arcade_cashier/src/features/sessions/presentation/sessions_controller.dart';
import 'package:arcade_cashier/src/features/sessions/presentation/active_session_dialog.dart';
import 'package:arcade_cashier/src/features/sessions/presentation/start_session_dialog.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session_type.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:arcade_cashier/src/utils/async_value_ui.dart';
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

    final roomsValue = ref.watch(roomsValuesProvider);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.dashboardTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(roomsValuesProvider),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push(AppRoutes.settings),
          ),
        ],
      ),
      body: roomsValue.when(
        data: (rooms) {
          if (rooms.isEmpty) {
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
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  final room = rooms[index];
                  return RoomCard(
                    room: room,
                    onTap: () {
                      if (room.currentStatus == RoomStatus.available) {
                        showDialog(
                          context: context,
                          builder: (context) => StartSessionDialog(room: room),
                        );
                      } else if (room.currentStatus == RoomStatus.occupied) {
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
        error: (e, st) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                loc.errorTitle,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  e.toString().contains('RealtimeSubscribeException')
                      ? loc.connectionError
                      : loc.errorMessage(e.toString()),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => ref.refresh(roomsValuesProvider),
                icon: const Icon(Icons.refresh),
                label: Text(loc.retry),
              ),
            ],
          ),
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
        label: const Text('Quick Order'),
        icon: const Icon(Icons.flash_on),
      ),
    );
  }
}
