import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arcade_cashier/src/constants/app_routes.dart';
import 'package:arcade_cashier/src/features/authentication/presentation/login_screen.dart';
import 'package:arcade_cashier/src/features/authentication/data/auth_repository.dart';
import 'package:arcade_cashier/src/features/authentication/presentation/splash_screen.dart';
import 'package:arcade_cashier/src/features/rooms/presentation/dashboard_screen.dart';
import 'package:arcade_cashier/src/features/rooms/presentation/manage_rooms_screen.dart';
import 'package:arcade_cashier/src/features/tables/presentation/tables_dashboard_screen.dart';
import 'package:arcade_cashier/src/features/tables/presentation/manage_tables_screen.dart';
import 'package:arcade_cashier/src/features/products/presentation/products_dashboard_screen.dart';
import 'package:arcade_cashier/src/features/invoices/presentation/invoices_history_screen.dart';
import 'package:arcade_cashier/src/features/reports/presentation/reports_screen.dart';
import 'package:arcade_cashier/src/features/settings/presentation/settings_screen.dart';

import 'package:arcade_cashier/src/utils/go_router_refresh_stream.dart';
import 'package:arcade_cashier/src/common_widgets/scaffold_with_navigation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    redirect: (context, state) async {
      final isLoggedIn = authRepository.isAuthenticated;
      final isLoggingIn = state.uri.path == AppRoutes.login;
      final isSplash = state.uri.path == '/splash';

      if (isSplash) {
        return isLoggedIn ? AppRoutes.rooms : AppRoutes.login;
      }

      if (!isLoggedIn) {
        return isLoggingIn ? null : AppRoutes.login;
      }

      if (isLoggingIn) {
        return AppRoutes.rooms;
      }

      // Route guard for admin-only routes
      final currentUser = await authRepository.getCurrentUser();
      final isAdmin = currentUser?.isAdmin ?? false;
      final path = state.uri.path;

      if (!isAdmin &&
          (path.startsWith(AppRoutes.analytics) ||
              path == AppRoutes.manageRooms ||
              path == AppRoutes.manageTables)) {
        return AppRoutes.rooms;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavigation(navigationShell: navigationShell);
        },
        branches: [
          // Branch 0: Rooms (was Dashboard)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.rooms,
                builder: (context, state) => const DashboardScreen(),
              ),
              // Alias for backward compatibility
              GoRoute(
                path: AppRoutes.dashboard,
                redirect: (context, state) => AppRoutes.rooms,
              ),
            ],
          ),
          // Branch 1: Tables (NEW)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.tables,
                builder: (context, state) => const TablesDashboardScreen(),
              ),
            ],
          ),
          // Branch 2: Products (was Branch 1)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.products,
                builder: (context, state) => const ProductsDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.invoices,
                builder: (context, state) => const InvoicesHistoryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.analytics,
                builder: (context, state) => const ReportsScreen(),
              ),
            ],
          ),
          // Branch 5: Settings (was Branch 4)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                builder: (context, state) => const SettingsScreen(),
                routes: [
                  GoRoute(
                    path: 'rooms',
                    builder: (context, state) => const ManageRoomsScreen(),
                  ),
                  GoRoute(
                    path: 'tables',
                    builder: (context, state) => const ManageTablesScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
