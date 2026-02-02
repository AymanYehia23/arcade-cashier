// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_orders_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sessionOrdersHash() => r'c57309015ad5e551570650584a74ddc9503c9ef7';

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

/// See also [sessionOrders].
@ProviderFor(sessionOrders)
const sessionOrdersProvider = SessionOrdersFamily();

/// See also [sessionOrders].
class SessionOrdersFamily extends Family<AsyncValue<List<Order>>> {
  /// See also [sessionOrders].
  const SessionOrdersFamily();

  /// See also [sessionOrders].
  SessionOrdersProvider call(int sessionId) {
    return SessionOrdersProvider(sessionId);
  }

  @override
  SessionOrdersProvider getProviderOverride(
    covariant SessionOrdersProvider provider,
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
  String? get name => r'sessionOrdersProvider';
}

/// See also [sessionOrders].
class SessionOrdersProvider extends AutoDisposeStreamProvider<List<Order>> {
  /// See also [sessionOrders].
  SessionOrdersProvider(int sessionId)
    : this._internal(
        (ref) => sessionOrders(ref as SessionOrdersRef, sessionId),
        from: sessionOrdersProvider,
        name: r'sessionOrdersProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$sessionOrdersHash,
        dependencies: SessionOrdersFamily._dependencies,
        allTransitiveDependencies:
            SessionOrdersFamily._allTransitiveDependencies,
        sessionId: sessionId,
      );

  SessionOrdersProvider._internal(
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
    Stream<List<Order>> Function(SessionOrdersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SessionOrdersProvider._internal(
        (ref) => create(ref as SessionOrdersRef),
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
  AutoDisposeStreamProviderElement<List<Order>> createElement() {
    return _SessionOrdersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SessionOrdersProvider && other.sessionId == sessionId;
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
mixin SessionOrdersRef on AutoDisposeStreamProviderRef<List<Order>> {
  /// The parameter `sessionId` of this provider.
  int get sessionId;
}

class _SessionOrdersProviderElement
    extends AutoDisposeStreamProviderElement<List<Order>>
    with SessionOrdersRef {
  _SessionOrdersProviderElement(super.provider);

  @override
  int get sessionId => (origin as SessionOrdersProvider).sessionId;
}

String _$sessionOrdersControllerHash() =>
    r'a314fb259a0d398f4b44700b4478e21c5082b474';

/// See also [SessionOrdersController].
@ProviderFor(SessionOrdersController)
final sessionOrdersControllerProvider =
    AutoDisposeAsyncNotifierProvider<SessionOrdersController, void>.internal(
      SessionOrdersController.new,
      name: r'sessionOrdersControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sessionOrdersControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SessionOrdersController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
