// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sessions_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activeSessionHash() => r'caf32fda37d89f4a0cfacad4ea1eb6b4fe5d0ce8';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [activeSession].
@ProviderFor(activeSession)
const activeSessionProvider = ActiveSessionFamily();

/// See also [activeSession].
class ActiveSessionFamily extends Family<AsyncValue<Session?>> {
  /// See also [activeSession].
  const ActiveSessionFamily();

  /// See also [activeSession].
  ActiveSessionProvider call(int roomId) {
    return ActiveSessionProvider(roomId);
  }

  @override
  ActiveSessionProvider getProviderOverride(
    covariant ActiveSessionProvider provider,
  ) {
    return call(provider.roomId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'activeSessionProvider';
}

/// See also [activeSession].
class ActiveSessionProvider extends AutoDisposeFutureProvider<Session?> {
  /// See also [activeSession].
  ActiveSessionProvider(int roomId)
    : this._internal(
        (ref) => activeSession(ref as ActiveSessionRef, roomId),
        from: activeSessionProvider,
        name: r'activeSessionProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$activeSessionHash,
        dependencies: ActiveSessionFamily._dependencies,
        allTransitiveDependencies:
            ActiveSessionFamily._allTransitiveDependencies,
        roomId: roomId,
      );

  ActiveSessionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.roomId,
  }) : super.internal();

  final int roomId;

  @override
  Override overrideWith(
    FutureOr<Session?> Function(ActiveSessionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ActiveSessionProvider._internal(
        (ref) => create(ref as ActiveSessionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        roomId: roomId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Session?> createElement() {
    return _ActiveSessionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ActiveSessionProvider && other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ActiveSessionRef on AutoDisposeFutureProviderRef<Session?> {
  /// The parameter `roomId` of this provider.
  int get roomId;
}

class _ActiveSessionProviderElement
    extends AutoDisposeFutureProviderElement<Session?>
    with ActiveSessionRef {
  _ActiveSessionProviderElement(super.provider);

  @override
  int get roomId => (origin as ActiveSessionProvider).roomId;
}

String _$sessionByIdHash() => r'b76e1ae4c3a5a17172bf5a57f9d7706eed3006b9';

/// See also [sessionById].
@ProviderFor(sessionById)
const sessionByIdProvider = SessionByIdFamily();

/// See also [sessionById].
class SessionByIdFamily extends Family<AsyncValue<Session?>> {
  /// See also [sessionById].
  const SessionByIdFamily();

  /// See also [sessionById].
  SessionByIdProvider call(int sessionId) {
    return SessionByIdProvider(sessionId);
  }

  @override
  SessionByIdProvider getProviderOverride(
    covariant SessionByIdProvider provider,
  ) {
    return call(provider.sessionId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'sessionByIdProvider';
}

/// See also [sessionById].
class SessionByIdProvider extends AutoDisposeFutureProvider<Session?> {
  /// See also [sessionById].
  SessionByIdProvider(int sessionId)
    : this._internal(
        (ref) => sessionById(ref as SessionByIdRef, sessionId),
        from: sessionByIdProvider,
        name: r'sessionByIdProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$sessionByIdHash,
        dependencies: SessionByIdFamily._dependencies,
        allTransitiveDependencies: SessionByIdFamily._allTransitiveDependencies,
        sessionId: sessionId,
      );

  SessionByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sessionId,
  }) : super.internal();

  final int sessionId;

  @override
  Override overrideWith(
    FutureOr<Session?> Function(SessionByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SessionByIdProvider._internal(
        (ref) => create(ref as SessionByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sessionId: sessionId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Session?> createElement() {
    return _SessionByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SessionByIdProvider && other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SessionByIdRef on AutoDisposeFutureProviderRef<Session?> {
  /// The parameter `sessionId` of this provider.
  int get sessionId;
}

class _SessionByIdProviderElement
    extends AutoDisposeFutureProviderElement<Session?>
    with SessionByIdRef {
  _SessionByIdProviderElement(super.provider);

  @override
  int get sessionId => (origin as SessionByIdProvider).sessionId;
}

String _$sessionsControllerHash() =>
    r'5f95236505a7780c1e3951c5f82985eda6b6de4d';

/// See also [SessionsController].
@ProviderFor(SessionsController)
final sessionsControllerProvider =
    AsyncNotifierProvider<SessionsController, void>.internal(
      SessionsController.new,
      name: r'sessionsControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sessionsControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SessionsController = AsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
