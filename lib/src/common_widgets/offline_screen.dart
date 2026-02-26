import 'package:arcade_cashier/src/common_widgets/logo_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Full-screen offline state that blocks app interaction when there's no internet.
///
/// Displays a centered UI with offline icon, message, and retry button.
/// Automatically dismisses when internet connection is restored.
class OfflineScreen extends ConsumerStatefulWidget {
  const OfflineScreen({super.key});

  @override
  ConsumerState<OfflineScreen> createState() => _OfflineScreenState();
}

class _OfflineScreenState extends ConsumerState<OfflineScreen> {
  bool _isRetrying = false;

  Future<void> _retryConnection() async {
    setState(() {
      _isRetrying = true;
    });

    // Wait a moment to show loading state
    await Future.delayed(const Duration(milliseconds: 500));

    // The provider will automatically check and update
    // Just reset the loading state
    if (mounted) {
      setState(() {
        _isRetrying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Offline Icon
              Icon(
                Icons.cloud_off_outlined,
                size: 100,
                color: Colors.grey.shade600,
              ),
              const SizedBox(height: 32),

              // Heading
              Text(
                'No Internet Connection',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Description
              Text(
                'Please check your connection and try again.\nThe app requires an active internet connection to function.',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade400),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // Retry Button
              _isRetrying
                  ? const LogoLoadingIndicator()
                  : ElevatedButton.icon(
                      onPressed: _retryConnection,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry Connection'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
