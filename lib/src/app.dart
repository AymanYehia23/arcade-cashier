import 'package:arcade_cashier/src/features/settings/application/locale_controller.dart';
import 'package:arcade_cashier/src/constants/app_constants.dart';
import 'package:arcade_cashier/src/constants/app_theme.dart';
import 'package:arcade_cashier/src/core/app_router.dart';
import 'package:arcade_cashier/src/core/connectivity_provider.dart';
import 'package:arcade_cashier/src/common_widgets/offline_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final locale = ref.watch(localeControllerProvider);

    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      restorationScopeId: AppConstants.restorationScopeId,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
      locale: locale,
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
      themeMode: ThemeMode.dark,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      builder: (context, child) {
        return Consumer(
          builder: (context, ref, _) {
            final hasInternetAsync = ref.watch(hasInternetConnectionV2Provider);

            return hasInternetAsync.when(
              data: (hasInternet) {
                // Show full-screen offline state when no internet
                if (!hasInternet) {
                  return const OfflineScreen();
                }
                // Show normal app when internet is available
                return child ?? const SizedBox.shrink();
              },
              loading: () => child ?? const SizedBox.shrink(),
              error: (_, __) => child ?? const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}
