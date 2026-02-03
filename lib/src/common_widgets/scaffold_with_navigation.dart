import 'package:arcade_cashier/src/constants/app_sizes.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:arcade_cashier/src/features/authentication/data/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavigation extends ConsumerWidget {
  const ScaffoldWithNavigation({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  // Map navigation index to actual branch index
  // Branch indices: 0=Dashboard, 1=Products, 2=Invoices, 3=Analytics, 4=Settings
  int _mapToBranchIndex(int navIndex, bool isAdmin) {
    if (isAdmin) {
      return navIndex; // Direct mapping for admins
    } else {
      // For non-admins: 0=Dashboard, 1=Products, 2=Invoices, 3=Settings
      // Map: 0->0, 1->1, 2->2, 3->4 (skip Analytics branch at index 3)
      return navIndex >= 3 ? navIndex + 1 : navIndex;
    }
  }

  // Get current selected navigation index from branch index
  int _getCurrentNavIndex(bool isAdmin, int branchIndex) {
    if (isAdmin) {
      return branchIndex;
    } else {
      // Reverse mapping: branch 4 (Settings) -> nav index 3
      return branchIndex >= 4 ? branchIndex - 1 : branchIndex;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;

    // Watch the current user to check role
    // Watch the current user to check role
    final authState = ref.watch(authStateChangesProvider);
    final isAdmin = authState.value?.isAdmin ?? false;

    // Build navigation items based on role
    final destinations = <NavigationDestination>[
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
      if (isAdmin)
        NavigationDestination(
          icon: const Icon(Icons.analytics),
          label: loc.analytics,
        ),
      NavigationDestination(
        icon: const Icon(Icons.settings),
        label: loc.settingsTitle,
      ),
    ];

    final railDestinations = <NavigationRailDestination>[
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
      if (isAdmin)
        NavigationRailDestination(
          icon: const Icon(Icons.analytics),
          label: Text(loc.analytics),
        ),
      NavigationRailDestination(
        icon: const Icon(Icons.settings),
        label: Text(loc.settingsTitle),
      ),
    ];

    // Responsive breakpoints
    if (width < Breakpoint.mobile) {
      // Mobile Layout: BottomNavigationBar
      return Scaffold(
        body: navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: _getCurrentNavIndex(
            isAdmin,
            navigationShell.currentIndex,
          ),
          destinations: destinations,
          onDestinationSelected: (index) {
            final branchIndex = _mapToBranchIndex(index, isAdmin);
            navigationShell.goBranch(
              branchIndex,
              initialLocation: branchIndex == navigationShell.currentIndex,
            );
          },
        ),
      );
    } else {
      // Desktop/Web Layout: NavigationRail
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              extended: width >= Breakpoint.desktop,
              selectedIndex: _getCurrentNavIndex(
                isAdmin,
                navigationShell.currentIndex,
              ),
              onDestinationSelected: (index) {
                final branchIndex = _mapToBranchIndex(index, isAdmin);
                navigationShell.goBranch(
                  branchIndex,
                  initialLocation: branchIndex == navigationShell.currentIndex,
                );
              },
              labelType: width >= Breakpoint.desktop
                  ? NavigationRailLabelType.none
                  : NavigationRailLabelType.all,
              destinations: railDestinations,
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: navigationShell),
          ],
        ),
      );
    }
  }
}
