import 'package:arcade_cashier/src/common_widgets/logo_loading_indicator.dart';
import 'package:arcade_cashier/src/constants/app_routes.dart';
import 'package:arcade_cashier/src/core/app_router.dart';
import 'package:arcade_cashier/src/features/authentication/data/auth_repository.dart';
import 'package:arcade_cashier/src/features/shifts/data/cashier_repository.dart';
import 'package:arcade_cashier/src/features/shifts/data/shift_repository.dart';
import 'package:arcade_cashier/src/features/shifts/domain/cashier.dart';
import 'package:arcade_cashier/src/features/shifts/presentation/pin_keypad_widget.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Locked screen that requires cashier login and shift start.
/// Three-step flow: 1) Select Cashier, 2) Enter PIN, 3) Enter Starting Cash.
class StartShiftScreen extends ConsumerStatefulWidget {
  const StartShiftScreen({super.key});

  @override
  ConsumerState<StartShiftScreen> createState() => _StartShiftScreenState();
}

class _StartShiftScreenState extends ConsumerState<StartShiftScreen> {
  // Steps: 0 = select cashier, 1 = enter pin, 2 = enter starting cash
  int _step = 0;
  Cashier? _selectedCashier;
  String? _pinError;
  final _cashController = TextEditingController();
  bool _isStarting = false;
  bool _isAdmin = false;

  @override
  void initState() {
    super.initState();
    _checkAdmin();
  }

  Future<void> _checkAdmin() async {
    final user = await ref.read(authRepositoryProvider).getCurrentUser();
    if (mounted) {
      setState(() {
        _isAdmin = user?.isAdmin ?? false;
      });
    }
  }

  @override
  void dispose() {
    _cashController.dispose();
    super.dispose();
  }

  void _onCashierSelected(Cashier cashier) {
    setState(() {
      _selectedCashier = cashier;
      _step = 1;
      _pinError = null;
    });
  }

  void _onPinEntered(String pin) {
    if (_selectedCashier == null) return;
    if (pin == _selectedCashier!.pinCode) {
      setState(() {
        _step = 2;
        _pinError = null;
      });
    } else {
      setState(() {
        _pinError = AppLocalizations.of(context)!.wrongPin;
      });
    }
  }

  Future<void> _startShift() async {
    if (_selectedCashier == null) return;
    final cash = double.tryParse(_cashController.text) ?? 0.0;

    setState(() => _isStarting = true);

    try {
      await ref
          .read(shiftRepositoryProvider)
          .startShift(
            cashierId: _selectedCashier!.id!,
            startingCash: cash,
            cashierName: _selectedCashier!.name,
          );
      // Router redirect will automatically unlock the app
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
        setState(() => _isStarting = false);
      }
    }
  }

  void _goBack() {
    setState(() {
      if (_step > 0) {
        _step--;
        _pinError = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final cashiersAsync = ref.watch(activeCashiersProvider);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
                        Icon(
                          Icons.point_of_sale,
                          size: 48,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          loc.startShift,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Step indicator
                        _StepIndicator(currentStep: _step),
                        const SizedBox(height: 24),

                        // Step content
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: _buildStepContent(loc, theme, cashiersAsync),
                        ),

                        // Back button
                        if (_step > 0) ...[
                          const SizedBox(height: 16),
                          TextButton.icon(
                            onPressed: _goBack,
                            icon: const Icon(Icons.arrow_back),
                            label: Text(loc.back),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                // Manage Cashiers button — visible on step 0 for admin only
                if (_step == 0 && _isAdmin) ...[
                  const SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: () {
                      context.push(AppRoutes.manageCashiers).then((_) {
                        ref.invalidate(activeCashiersProvider);
                      });
                    },
                    icon: const Icon(Icons.settings),
                    label: Text(loc.manageCashiers),
                  ),
                ],
                // Skip button — visible only for admin users
                if (_isAdmin) ...[
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () {
                      ref.read(adminSkippedShiftProvider.notifier).state = true;
                      context.go(AppRoutes.rooms);
                    },
                    icon: const Icon(Icons.skip_next),
                    label: Text(loc.skipShift),
                  ),
                ],
                // Logout button
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () => ref.read(authRepositoryProvider).signOut(),
                  icon: const Icon(Icons.logout),
                  label: Text(loc.logout),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent(
    AppLocalizations loc,
    ThemeData theme,
    AsyncValue<List<Cashier>> cashiersAsync,
  ) {
    switch (_step) {
      case 0:
        return _buildCashierSelection(loc, theme, cashiersAsync);
      case 1:
        return _buildPinEntry(loc);
      case 2:
        return _buildStartingCash(loc, theme);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildCashierSelection(
    AppLocalizations loc,
    ThemeData theme,
    AsyncValue<List<Cashier>> cashiersAsync,
  ) {
    return cashiersAsync.when(
      data: (cashiers) {
        if (cashiers.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Icon(Icons.person_off, size: 48, color: Colors.grey),
                const SizedBox(height: 12),
                Text(loc.noCashiersFound, textAlign: TextAlign.center),
              ],
            ),
          );
        }
        return Column(
          key: const ValueKey('cashier-selection'),
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              loc.selectCashier,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ...cashiers.map(
              (cashier) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: theme.colorScheme.outlineVariant),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Text(
                      cashier.name[0].toUpperCase(),
                      style: TextStyle(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(cashier.name),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _onCashierSelected(cashier),
                ),
              ),
            ),
          ],
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.all(48),
        child: LogoLoadingIndicator(),
      ),
      error: (e, _) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 12),
            Text('$e'),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => ref.invalidate(activeCashiersProvider),
              child: Text(loc.retry),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinEntry(AppLocalizations loc) {
    return Column(
      key: const ValueKey('pin-entry'),
      children: [
        Text(
          _selectedCashier?.name ?? '',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 20),
        PinKeypadWidget(
          title: loc.enterPin,
          errorText: _pinError,
          onPinComplete: _onPinEntered,
        ),
      ],
    );
  }

  Widget _buildStartingCash(AppLocalizations loc, ThemeData theme) {
    return Column(
      key: const ValueKey('starting-cash'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          loc.verifyStartingCash,
          style: theme.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _cashController,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            labelText: loc.startingCashAmount,
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.payments),
            suffixText: loc.egp,
          ),
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall,
          onSubmitted: (_) => _startShift(),
        ),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: _isStarting ? null : _startShift,
          icon: _isStarting
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.play_arrow),
          label: Text(loc.startShift),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.currentStep});

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final isActive = index <= currentStep;
        return Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surfaceContainerHighest,
              ),
              child: Center(
                child: index < currentStep
                    ? Icon(
                        Icons.check,
                        size: 18,
                        color: theme.colorScheme.onPrimary,
                      )
                    : Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: isActive
                              ? theme.colorScheme.onPrimary
                              : theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            if (index < 2)
              Container(
                width: 40,
                height: 2,
                color: index < currentStep
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surfaceContainerHighest,
              ),
          ],
        );
      }),
    );
  }
}
