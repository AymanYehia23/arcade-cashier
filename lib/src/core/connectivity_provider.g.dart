// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$connectivityHash() => r'2b45f46f28b989bcf776392819952488633323fc';

/// Provides a stream of connectivity status changes.
///
/// Returns a [List<ConnectivityResult>] that indicates the current
/// connectivity state (WiFi, Mobile, Ethernet, None, etc.).
///
/// Copied from [connectivity].
@ProviderFor(connectivity)
final connectivityProvider = StreamProvider<List<ConnectivityResult>>.internal(
  connectivity,
  name: r'connectivityProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$connectivityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConnectivityRef = StreamProviderRef<List<ConnectivityResult>>;
String _$hasInternetConnectionHash() =>
    r'080c64aaefebdec12399d7a1d86d56d9c74b9174';

/// Provides a stream indicating whether the app has actual internet access.
///
/// Combines connectivity status with internet reachability checks to detect
/// scenarios where device is connected to WiFi/network but has no internet.
///
/// Returns `true` when internet is available, `false` otherwise.
///
/// Copied from [hasInternetConnection].
@ProviderFor(hasInternetConnection)
final hasInternetConnectionProvider = StreamProvider<bool>.internal(
  hasInternetConnection,
  name: r'hasInternetConnectionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasInternetConnectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HasInternetConnectionRef = StreamProviderRef<bool>;
String _$hasInternetConnectionV2Hash() =>
    r'c94634fc5612cf88c08048eecf8b32197ce7746f';

/// Improved implementation using StreamController for better control.
///
/// This version properly emits updates when internet status changes,
/// even when WiFi connection remains stable.
///
/// Copied from [hasInternetConnectionV2].
@ProviderFor(hasInternetConnectionV2)
final hasInternetConnectionV2Provider = StreamProvider<bool>.internal(
  hasInternetConnectionV2,
  name: r'hasInternetConnectionV2Provider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasInternetConnectionV2Hash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HasInternetConnectionV2Ref = StreamProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
