import 'package:arcade_cashier/src/features/rooms/data/rooms_repository.dart';
import 'package:arcade_cashier/src/features/rooms/presentation/room_form_controller.dart';
import 'package:arcade_cashier/src/features/rooms/presentation/room_form_dialog.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:arcade_cashier/src/utils/async_value_ui.dart';
import 'package:arcade_cashier/src/common_widgets/responsive_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageRoomsScreen extends ConsumerWidget {
  const ManageRoomsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      roomFormControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final roomsValue = ref.watch(roomsValuesProvider);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(loc.manageRooms)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const RoomFormDialog(),
        ),
        child: const Icon(Icons.add),
      ),
      body: ResponsiveCenter(
        child: roomsValue.when(
          data: (rooms) {
            if (rooms.isEmpty) {
              return Center(child: Text(loc.noRoomsFound));
            }
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                final room = rooms[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          room.name,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${room.deviceType.displayTitle} \n${loc.singleRate}: ${room.singleMatchHourlyRate} | ${loc.multiRate}: ${room.multiMatchHourlyRate}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FilledButton.tonalIcon(
                              icon: const Icon(Icons.edit),
                              label: Text(loc.editRoom),
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) =>
                                    RoomFormDialog(room: room),
                              ),
                            ),
                            const SizedBox(width: 12),
                            FilledButton.icon(
                              style: FilledButton.styleFrom(
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.error,
                                foregroundColor: Theme.of(
                                  context,
                                ).colorScheme.onError,
                              ),
                              icon: const Icon(Icons.delete),
                              label: Text(loc.deleteRoom),
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(loc.deleteRoom),
                                  content: Text(loc.confirmDelete),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text(loc.cancel),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        ref
                                            .read(
                                              roomFormControllerProvider
                                                  .notifier,
                                            )
                                            .deleteRoom(room.id);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(loc.deleteRoom),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          error: (e, st) => Center(child: Text(loc.errorMessage(e.toString()))),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
