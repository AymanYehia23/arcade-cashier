import 'package:arcade_cashier/src/features/tables/domain/cafe_table.dart';
import 'package:arcade_cashier/src/features/tables/presentation/tables_controller.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:arcade_cashier/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TableFormDialog extends ConsumerStatefulWidget {
  const TableFormDialog({super.key, this.table});
  final CafeTable? table;

  @override
  ConsumerState<TableFormDialog> createState() => _TableFormDialogState();
}

class _TableFormDialogState extends ConsumerState<TableFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _tableNumberController = TextEditingController();
  TableStatus _selectedStatus = TableStatus.available;

  @override
  void initState() {
    super.initState();
    if (widget.table != null) {
      _nameController.text = widget.table!.name;
      _tableNumberController.text = widget.table!.tableNumber?.toString() ?? '';
      _selectedStatus = widget.table!.currentStatus;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _tableNumberController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final tableNumberText = _tableNumberController.text.trim();
      final tableNumber =
          tableNumberText.isEmpty ? null : int.parse(tableNumberText);

      final controller = ref.read(tablesControllerProvider.notifier);

      if (widget.table == null) {
        // Creating new table (status defaults to available)
        await controller.createTable(
          name: name,
          tableNumber: tableNumber,
        );
      } else {
        // Updating existing table
        await controller.updateTableDetails(
          tableId: widget.table!.id,
          name: name,
          tableNumber: tableNumber,
          status: _selectedStatus,
        );
      }

      // Check if operation was successful
      final state = ref.read(tablesControllerProvider);
      if (!state.hasError && mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      tablesControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final state = ref.watch(tablesControllerProvider);
    final loc = AppLocalizations.of(context)!;
    final isEditing = widget.table != null;

    return AlertDialog(
      title: Text(isEditing ? loc.editTable : loc.addTable),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: loc.tableName),
                validator: (value) =>
                    value == null || value.isEmpty ? loc.tableName : null,
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tableNumberController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: '${loc.tableNumber} (${loc.optional})',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onFieldSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<TableStatus>(
                initialValue: _selectedStatus,
                decoration: InputDecoration(labelText: loc.status),
                items: TableStatus.values
                    .map(
                      (status) => DropdownMenuItem(
                        value: status,
                        child: Text(_getStatusLabel(status, loc)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  }
                },
              ),
            ],
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
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(loc.save),
        ),
      ],
    );
  }

  String _getStatusLabel(TableStatus status, AppLocalizations loc) {
    switch (status) {
      case TableStatus.available:
        return loc.statusAvailable;
      case TableStatus.occupied:
        return loc.statusOccupied;
      case TableStatus.maintenance:
        return loc.statusMaintenance;
    }
  }
}
