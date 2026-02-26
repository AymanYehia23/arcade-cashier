import 'package:arcade_cashier/src/common_widgets/logo_loading_indicator.dart';
import 'package:arcade_cashier/src/features/shifts/data/cashier_repository.dart';
import 'package:arcade_cashier/src/features/shifts/domain/cashier.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Admin screen for managing cashiers (add, edit, deactivate).
class ManageCashiersScreen extends ConsumerWidget {
  const ManageCashiersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final cashiersAsync = ref.watch(allCashiersProvider);

    return Scaffold(
      appBar: AppBar(title: Text(loc.manageCashiers)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCashierFormDialog(context, ref, loc),
        icon: const Icon(Icons.add),
        label: Text(loc.addCashier),
      ),
      body: cashiersAsync.when(
        data: (cashiers) {
          if (cashiers.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.person_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(loc.noCashiersFound),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: cashiers.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final cashier = cashiers[index];
              return _CashierListTile(
                cashier: cashier,
                onEdit: () =>
                    _showCashierFormDialog(context, ref, loc, cashier: cashier),
                onToggleActive: () =>
                    _toggleCashierActive(context, ref, cashier, loc),
              );
            },
          );
        },
        loading: () => const Center(child: LogoLoadingIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Future<void> _showCashierFormDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations loc, {
    Cashier? cashier,
  }) async {
    final nameController = TextEditingController(text: cashier?.name ?? '');
    final pinController = TextEditingController(text: cashier?.pinCode ?? '');
    final formKey = GlobalKey<FormState>();
    final isEditing = cashier != null;

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(isEditing ? loc.editCashier : loc.addCashier),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: loc.cashierName,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? loc.fieldRequired : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: pinController,
                decoration: InputDecoration(
                  labelText: loc.pinCode,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  helperText: loc.pinCodeHelper,
                ),
                keyboardType: TextInputType.number,
                maxLength: 4,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                obscureText: true,
                validator: (v) {
                  if (v == null || v.length != 4) return loc.pinCodeValidation;
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(loc.cancel),
          ),
          FilledButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;

              try {
                final repo = ref.read(cashierRepositoryProvider);
                if (isEditing) {
                  await repo.updateCashier(
                    cashier.copyWith(
                      name: nameController.text.trim(),
                      pinCode: pinController.text,
                    ),
                  );
                } else {
                  await repo.createCashier(
                    Cashier(
                      name: nameController.text.trim(),
                      pinCode: pinController.text,
                    ),
                  );
                }
                ref.invalidate(allCashiersProvider);
                ref.invalidate(activeCashiersProvider);
                if (dialogContext.mounted) Navigator.pop(dialogContext, true);
              } catch (e) {
                if (dialogContext.mounted) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    SnackBar(
                      content: Text('Error: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: Text(loc.save),
          ),
        ],
      ),
    );

    if (result == true) {
      nameController.dispose();
      pinController.dispose();
    }
  }

  Future<void> _toggleCashierActive(
    BuildContext context,
    WidgetRef ref,
    Cashier cashier,
    AppLocalizations loc,
  ) async {
    try {
      final repo = ref.read(cashierRepositoryProvider);
      if (cashier.isActive) {
        await repo.deactivateCashier(cashier.id!);
      } else {
        await repo.reactivateCashier(cashier.id!);
      }
      ref.invalidate(allCashiersProvider);
      ref.invalidate(activeCashiersProvider);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }
}

class _CashierListTile extends StatelessWidget {
  const _CashierListTile({
    required this.cashier,
    required this.onEdit,
    required this.onToggleActive,
  });

  final Cashier cashier;
  final VoidCallback onEdit;
  final VoidCallback onToggleActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: cashier.isActive
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surfaceContainerHighest,
          child: Text(
            cashier.name[0].toUpperCase(),
            style: TextStyle(
              color: cashier.isActive
                  ? theme.colorScheme.onPrimaryContainer
                  : theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          cashier.name,
          style: TextStyle(
            decoration: cashier.isActive ? null : TextDecoration.lineThrough,
          ),
        ),
        subtitle: Text(
          cashier.isActive ? loc.active : loc.inactive,
          style: TextStyle(
            color: cashier.isActive ? Colors.green : Colors.grey,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
              tooltip: loc.editCashier,
            ),
            IconButton(
              icon: Icon(
                cashier.isActive ? Icons.person_off : Icons.person_add,
              ),
              onPressed: onToggleActive,
              tooltip: cashier.isActive
                  ? loc.deactivateCashier
                  : loc.activateCashier,
            ),
          ],
        ),
      ),
    );
  }
}
