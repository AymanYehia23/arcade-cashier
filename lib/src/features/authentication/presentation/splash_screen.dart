import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // A simple loading screen.
    // In a real app, you might show a logo or a nice animation.
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context)?.loading ?? 'Loading...'),
          ],
        ),
      ),
    );
  }
}
