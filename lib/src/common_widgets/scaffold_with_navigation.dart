import 'package:arcade_cashier/src/constants/app_sizes.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavigation extends StatelessWidget {
  const ScaffoldWithNavigation({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;

    // Responsive breakpoints
    if (width < Breakpoint.mobile) {
      // Mobile Layout: BottomNavigationBar
      return Scaffold(
        body: navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.dashboard),
              label: loc.dashboardTitle,
            ),
            NavigationDestination(
              icon: const Icon(Icons.inventory_2),
              label: loc.inventory,
            ),
            NavigationDestination(
              icon: const Icon(Icons.receipt_long),
              label: loc.invoices,
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings),
              label: loc.settingsTitle,
            ),
          ],
          onDestinationSelected: _goBranch,
        ),
      );
    } else {
      // Desktop/Web Layout: NavigationRail
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              extended: width >= Breakpoint.desktop,
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _goBranch,
              labelType: width >= Breakpoint.desktop
                  ? NavigationRailLabelType.none
                  : NavigationRailLabelType.all,
              destinations: [
                NavigationRailDestination(
                  icon: const Icon(Icons.dashboard),
                  label: Text(loc.dashboardTitle),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.inventory_2),
                  label: Text(loc.inventory),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.receipt_long),
                  label: Text(loc.invoices),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.settings),
                  label: Text(loc.settingsTitle),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: navigationShell),
          ],
        ),
      );
    }
  }
}
