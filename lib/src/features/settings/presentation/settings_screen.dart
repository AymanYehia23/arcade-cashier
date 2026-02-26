import 'package:arcade_cashier/src/features/settings/presentation/printer_settings_section.dart';
import 'package:arcade_cashier/src/features/settings/application/locale_controller.dart';
import 'package:arcade_cashier/src/features/authentication/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arcade_cashier/src/constants/app_routes.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:arcade_cashier/src/common_widgets/responsive_center.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final locale = ref.watch(localeControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(loc.settingsTitle)),
      body: ResponsiveCenter(
        child: ListView(
          children: [
            _SectionHeader(title: loc.general),
            SwitchListTile(
              title: Text(loc.language),
              subtitle: Text(
                locale.languageCode == 'en' ? 'English' : 'العربية',
              ),
              value: locale.languageCode == 'ar',
              onChanged: (_) {
                ref.read(localeControllerProvider.notifier).toggleLocale();
              },
              secondary: const Icon(Icons.language),
            ),
            const Divider(),
            // Management section - Only visible to admins
            if (ref.watch(authStateChangesProvider).value?.isAdmin ??
                false) ...[
              _SectionHeader(title: loc.management),
              ListTile(
                leading: const Icon(Icons.meeting_room),
                title: Text(loc.manageRooms),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(AppRoutes.manageRooms),
              ),
              ListTile(
                leading: const Icon(Icons.table_restaurant),
                title: Text(loc.manageTables),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(AppRoutes.manageTables),
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: Text(loc.manageCashiers),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(AppRoutes.manageCashiers),
              ),
              const Divider(),
            ],
            const PrinterSettingsSection(),
            _SectionHeader(title: loc.account),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.error,
              ),
              title: Text(
                loc.logout,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              onTap: () async {
                await ref.read(authRepositoryProvider).signOut();
                // Router will handle redirect
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
