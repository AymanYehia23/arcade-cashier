import 'package:arcade_cashier/src/common_widgets/error_state_widget.dart';
import 'package:arcade_cashier/src/common_widgets/responsive_center.dart';
import 'package:arcade_cashier/src/features/tables/data/tables_repository.dart';
import 'package:arcade_cashier/src/features/tables/presentation/tables_controller.dart';
import 'package:arcade_cashier/src/features/tables/presentation/dialogs/table_form_dialog.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:arcade_cashier/src/utils/async_value_ui.dart';
import 'package:arcade_cashier/src/utils/error_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageTablesScreen extends ConsumerWidget {
  const ManageTablesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      tablesControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final tablesValue = ref.watch(tablesValuesProvider);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.manageTables),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(tablesValuesProvider),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const TableFormDialog(),
        ),
        child: const Icon(Icons.add),
      ),
      body: ResponsiveCenter(
        child: tablesValue.when(
          data: (tables) {
            if (tables.isEmpty) {
              return Center(child: Text(loc.noTablesAvailable));
            }
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: tables.length,
              itemBuilder: (context, index) {
                final table = tables[index];
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
                          table.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        if (table.tableNumber != null) ...[
                          Text(
                            '${loc.tableNumber}: ${table.tableNumber}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                        ],
                        Text(
                          '${loc.status}: ${_getStatusLabel(table.currentStatus, loc)}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FilledButton.tonalIcon(
                              icon: const Icon(Icons.edit),
                              label: Text(loc.editTable),
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) =>
                                    TableFormDialog(table: table),
                              ),
                            ),
                            const SizedBox(width: 12),
                            FilledButton.icon(
                              style: FilledButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.error,
                                foregroundColor:
                                    Theme.of(context).colorScheme.onError,
                              ),
                              icon: const Icon(Icons.delete),
                              label: Text(loc.deleteTable),
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(loc.deleteTable),
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
                                              tablesControllerProvider.notifier,
                                            )
                                            .deleteTable(table.id);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(loc.deleteTable),
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
          error: (e, st) => ErrorStateWidget(
            message: getUserFriendlyErrorMessage(e, context),
            onRetry: () => ref.refresh(tablesValuesProvider),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  String _getStatusLabel(status, AppLocalizations loc) {
    switch (status.toString().split('.').last) {
      case 'available':
        return loc.statusAvailable;
      case 'occupied':
        return loc.statusOccupied;
      case 'maintenance':
        return loc.statusMaintenance;
      default:
        return 'Unknown';
    }
  }
}
