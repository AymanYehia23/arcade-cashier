import 'package:arcade_cashier/src/constants/app_routes.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.settingsTitle)),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.meeting_room),
            title: Text(loc.manageRooms),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(AppRoutes.manageRooms),
          ),
        ],
      ),
    );
  }
}
