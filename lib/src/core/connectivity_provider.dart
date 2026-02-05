import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_provider.g.dart';

/// Provides a stream of connectivity status changes.
///
/// Returns a [List<ConnectivityResult>] that indicates the current
/// connectivity state (WiFi, Mobile, Ethernet, None, etc.).
@Riverpod(keepAlive: true)
Stream<List<ConnectivityResult>> connectivity(Ref ref) {
  return Connectivity().onConnectivityChanged;
}

/// Checks if there is actual internet connectivity by attempting to lookup
/// a reliable host.
///
/// Returns `true` if internet is reachable, `false` otherwise.
Future<bool> _hasInternetConnection() async {
  try {
    final result = await InternetAddress.lookup(
      'google.com',
    ).timeout(const Duration(seconds: 5));
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  } on TimeoutException catch (_) {
    return false;
  }
}

/// Provides a stream indicating whether the app has actual internet access.
///
/// Combines connectivity status with internet reachability checks to detect
/// scenarios where device is connected to WiFi/network but has no internet.
///
/// Returns `true` when internet is available, `false` otherwise.
@Riverpod(keepAlive: true)
Stream<bool> hasInternetConnection(Ref ref) async* {
  final connectivity = Connectivity();

  await for (final connectivityResults in connectivity.onConnectivityChanged) {
    // If no connectivity at all, definitely offline
    if (connectivityResults.contains(ConnectivityResult.none)) {
      yield false;
      continue;
    }

    // Has network connectivity, check if there's actual internet
    final hasInternet = await _hasInternetConnection();
    yield hasInternet;

    // If we have connectivity but no internet, periodically recheck
    // to detect when internet comes back
    if (!hasInternet) {
      // Set up periodic rechecks every 10 seconds
      final timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
        final stillHasInternet = await _hasInternetConnection();
        if (stillHasInternet) {
          timer.cancel();
        }
      });

      // Cancel timer when connectivity changes
      ref.onDispose(() => timer.cancel());
    }
  }
}

/// Improved implementation using StreamController for better control.
///
/// This version properly emits updates when internet status changes,
/// even when WiFi connection remains stable. Includes debouncing to prevent
/// brief offline flashes during app startup or network transitions.
@Riverpod(keepAlive: true)
Stream<bool> hasInternetConnectionV2(Ref ref) {
  final controller = StreamController<bool>();
  final connectivity = Connectivity();
  Timer? periodicTimer;
  Timer? debounceTimer;
  bool? lastKnownStatus;
  bool? pendingStatus;

  // Emit initial optimistic value (assume connected on startup)
  controller.add(true);
  lastKnownStatus = true;

  void emitStatusWithDebounce(bool hasInternet) {
    // Cancel any pending debounce timer
    debounceTimer?.cancel();

    // If transitioning to online, emit immediately (no delay)
    if (hasInternet) {
      if (lastKnownStatus != hasInternet) {
        lastKnownStatus = hasInternet;
        if (!controller.isClosed) {
          controller.add(hasInternet);
        }
      }
      pendingStatus = null;
      return;
    }

    // If transitioning to offline, debounce to prevent brief flashes
    pendingStatus = hasInternet;
    debounceTimer = Timer(const Duration(seconds: 2), () {
      if (pendingStatus == hasInternet && lastKnownStatus != hasInternet) {
        lastKnownStatus = hasInternet;
        if (!controller.isClosed) {
          controller.add(hasInternet);
        }
      }
      pendingStatus = null;
    });
  }

  void checkAndEmitInternetStatus() async {
    final hasInternet = await _hasInternetConnection();
    emitStatusWithDebounce(hasInternet);
  }

  // Listen to connectivity changes
  final subscription = connectivity.onConnectivityChanged.listen((
    connectivityResults,
  ) {
    // Cancel existing periodic timer
    periodicTimer?.cancel();

    // If no connectivity at all, definitely offline
    if (connectivityResults.contains(ConnectivityResult.none)) {
      emitStatusWithDebounce(false);
      return;
    }

    // Has network connectivity - check internet and set up periodic checks
    checkAndEmitInternetStatus();

    // Periodically recheck internet status (every 10 seconds)
    // This detects when internet goes down/up while WiFi stays connected
    periodicTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      checkAndEmitInternetStatus();
    });
  });

  // Cleanup
  ref.onDispose(() {
    periodicTimer?.cancel();
    debounceTimer?.cancel();
    subscription.cancel();
    controller.close();
  });

  return controller.stream;
}
