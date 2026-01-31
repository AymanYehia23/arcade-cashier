import 'package:arcade_cashier/src/features/rooms/domain/device_type.dart';
import 'package:arcade_cashier/src/features/rooms/domain/room.dart';
import 'package:arcade_cashier/src/features/rooms/presentation/room_form_controller.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:arcade_cashier/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RoomFormDialog extends ConsumerStatefulWidget {
  const RoomFormDialog({super.key, this.room});
  final Room? room;

  @override
  ConsumerState<RoomFormDialog> createState() => _RoomFormDialogState();
}

class _RoomFormDialogState extends ConsumerState<RoomFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _singleRateController = TextEditingController();
  final _multiRateController = TextEditingController();
  DeviceType? _selectedDeviceType;

  @override
  void initState() {
    super.initState();
    if (widget.room != null) {
      _nameController.text = widget.room!.name;
      _selectedDeviceType = widget.room!.deviceType;
      _singleRateController.text = widget.room!.singleMatchHourlyRate
          .toString();
      _multiRateController.text = widget.room!.multiMatchHourlyRate.toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _singleRateController.dispose();
    _multiRateController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final deviceType = _selectedDeviceType!;
      final singleRate = double.parse(_singleRateController.text.trim());
      final multiRate = double.parse(_multiRateController.text.trim());

      final controller = ref.read(roomFormControllerProvider.notifier);
      final success = widget.room == null
          ? await controller.createRoom(
              name: name,
              deviceType: deviceType,
              singleMatchHourlyRate: singleRate,
              multiMatchHourlyRate: multiRate,
            )
          : await controller.updateRoom(
              roomId: widget.room!.id,
              name: name,
              deviceType: deviceType,
              singleMatchHourlyRate: singleRate,
              multiMatchHourlyRate: multiRate,
            );

      if (success && mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      roomFormControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final state = ref.watch(roomFormControllerProvider);
    final loc = AppLocalizations.of(context)!;
    final isEditing = widget.room != null;

    return AlertDialog(
      title: Text(isEditing ? loc.editRoom : loc.addRoom),
      content: SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: loc.roomName),
                  validator: (value) =>
                      value == null || value.isEmpty ? loc.roomName : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<DeviceType>(
                  initialValue: _selectedDeviceType,
                  decoration: InputDecoration(labelText: loc.deviceType),
                  items: DeviceType.values
                      .map(
                        (type) => DropdownMenuItem(
                          value: type,
                          child: Text(type.displayTitle),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDeviceType = value;
                    });
                  },
                  validator: (value) => value == null ? loc.deviceType : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _singleRateController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: loc.singleRate,
                          hintText: loc.twoPlayers,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return loc.singleRate;
                          }
                          if (double.tryParse(value) == null) {
                            return loc.singleRate;
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _multiRateController,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _submit(),
                        decoration: InputDecoration(
                          labelText: loc.multiRate,
                          hintText: loc.fourPlayers,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return loc.multiRate;
                          }
                          if (double.tryParse(value) == null) {
                            return loc.multiRate;
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: state.isLoading ? null : () => context.pop(),
          child: Text(loc.cancel),
        ),
        FilledButton(
          onPressed: state.isLoading ? null : _submit,
          child: state.isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(),
                )
              : Text(loc.save),
        ),
      ],
    );
  }
}
