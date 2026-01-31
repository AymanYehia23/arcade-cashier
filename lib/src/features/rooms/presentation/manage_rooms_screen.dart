import 'package:arcade_cashier/src/features/rooms/data/rooms_repository.dart';
import 'package:arcade_cashier/src/features/rooms/presentation/room_form_controller.dart';
import 'package:arcade_cashier/src/features/rooms/presentation/room_form_dialog.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:arcade_cashier/src/utils/async_value_ui.dart';
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
      body: roomsValue.when(
        data: (rooms) {
          if (rooms.isEmpty) {
            return const Center(child: Text('No rooms found'));
          }
          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];
              return ListTile(
                title: Text(room.name),
                subtitle: Text(
                  '${room.deviceType.displayTitle} \n${room.singleMatchHourlyRate} / ${room.multiMatchHourlyRate} EGP',
                ),
                isThreeLine: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => RoomFormDialog(room: room),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(loc.deleteRoom),
                          content: Text(loc.confirmDelete),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(loc.cancel),
                            ),
                            TextButton(
                              onPressed: () {
                                ref
                                    .read(roomFormControllerProvider.notifier)
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
              );
            },
          );
        },
        error: (e, st) => Center(child: Text('Error: $e')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
