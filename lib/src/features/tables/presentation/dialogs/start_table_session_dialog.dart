import 'package:arcade_cashier/src/features/tables/domain/cafe_table.dart';
import 'package:arcade_cashier/src/features/tables/presentation/tables_controller.dart';
import 'package:arcade_cashier/src/features/sessions/presentation/sessions_controller.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:arcade_cashier/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartTableSessionDialog extends ConsumerWidget {
  const StartTableSessionDialog({
    super.key,
    required this.table,
  });

  final CafeTable table;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;

    ref.listen<AsyncValue>(
      sessionsControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final state = ref.watch(sessionsControllerProvider);
    final isLoading = state.isLoading;

    return AlertDialog(
      title: Text(loc.startSession),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${loc.table}: ${table.name}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.blue, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    loc.noTimerForTables,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : () => Navigator.of(context).pop(),
          child: Text(loc.cancel),
        ),
        ElevatedButton(
          onPressed: isLoading
              ? null
              : () async {
                  final session = await ref
                      .read(sessionsControllerProvider.notifier)
                      .startTableSession(tableId: table.id);

                  if (context.mounted) {
                    // Refresh tables provider (stream auto-updates)
                    ref.invalidate(tablesWithSessionsProvider);

                    // Pop once with the session result (null if failed)
                    Navigator.of(context).pop(session);
                  }
                },
          child: isLoading
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(loc.startSession),
        ),
      ],
    );
  }
}
