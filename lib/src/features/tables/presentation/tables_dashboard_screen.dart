import 'package:arcade_cashier/src/common_widgets/error_state_widget.dart';
import 'package:arcade_cashier/src/features/tables/domain/cafe_table.dart';
import 'package:arcade_cashier/src/features/tables/presentation/tables_controller.dart';
import 'package:arcade_cashier/src/features/tables/presentation/widgets/table_card.dart';
import 'package:arcade_cashier/src/features/tables/presentation/dialogs/start_table_session_dialog.dart';
import 'package:arcade_cashier/src/features/tables/presentation/dialogs/active_table_session_dialog.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:arcade_cashier/src/utils/async_value_ui.dart';
import 'package:arcade_cashier/src/utils/error_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TablesDashboardScreen extends ConsumerWidget {
  const TablesDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      tablesControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final tablesWithSessionsValue = ref.watch(tablesWithSessionsProvider);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.tables),
      ),
      body: tablesWithSessionsValue.when(
        data: (tablesWithSessions) {
          if (tablesWithSessions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.table_restaurant,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    loc.noTablesAvailable,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    loc.addTablesFromSettings,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                ],
              ),
            );
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
                itemCount: tablesWithSessions.length,
                itemBuilder: (context, index) {
                  final tableWithSession = tablesWithSessions[index];
                  final table = tableWithSession.table;
                  final activeSession = tableWithSession.activeSession;

                  return TableCard(
                    table: table,
                    activeSession: activeSession,
                    onTap: () => _handleTableTap(
                      context,
                      table,
                      activeSession,
                    ),
                  );
                },
              );
            },
          );
        },
        error: (e, st) => ErrorStateWidget(
          message: getUserFriendlyErrorMessage(e, context),
          onRetry: () => ref.invalidate(tablesWithSessionsProvider),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void _handleTableTap(
    BuildContext context,
    table,
    activeSession,
  ) async {
    if (table.currentStatus == TableStatus.maintenance) {
      // Don't allow interaction with tables in maintenance
      return;
    }

    if (activeSession != null) {
      // Show active session dialog
      await showDialog(
        context: context,
        builder: (context) => ActiveTableSessionDialog(
          table: table,
          session: activeSession,
        ),
      );
    } else {
      // Show start session dialog
      final session = await showDialog(
        context: context,
        builder: (context) => StartTableSessionDialog(table: table),
      );

      // If session was started and returned, show active session dialog
      if (session != null && context.mounted) {
        await showDialog(
          context: context,
          builder: (context) => ActiveTableSessionDialog(
            table: table,
            session: session,
          ),
        );
      }
    }
  }
}
