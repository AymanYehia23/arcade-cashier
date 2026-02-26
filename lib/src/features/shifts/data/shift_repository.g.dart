// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$shiftRepositoryHash() => r'5793fbb01a08b00dc966e345386a50444474132e';

/// See also [shiftRepository].
@ProviderFor(shiftRepository)
final shiftRepositoryProvider = Provider<ShiftRepository>.internal(
  shiftRepository,
  name: r'shiftRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$shiftRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ShiftRepositoryRef = ProviderRef<ShiftRepository>;
String _$currentShiftHash() => r'2b441b025a5b59948113bf5836d91a0cd1ebafab';

/// The global source of truth for the current open shift.
/// Returns null when no shift is open — used for app lock routing.
///
/// Copied from [currentShift].
@ProviderFor(currentShift)
final currentShiftProvider = StreamProvider<Shift?>.internal(
  currentShift,
  name: r'currentShiftProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentShiftHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentShiftRef = StreamProviderRef<Shift?>;
String _$shiftReportsHash() => r'741f2f259079179d2ce45bc5034172ad49069ee0';

/// Fetches the list of all shift report summaries.
///
/// Copied from [shiftReports].
@ProviderFor(shiftReports)
final shiftReportsProvider =
    AutoDisposeFutureProvider<List<ShiftReportSummary>>.internal(
      shiftReports,
      name: r'shiftReportsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$shiftReportsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ShiftReportsRef =
    AutoDisposeFutureProviderRef<List<ShiftReportSummary>>;
String _$shiftInvoicesHash() => r'6f23a95ca565164712c8fab36752db516bf1a40b';

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

/// Fetches all invoices for a given shift ID.
///
/// Copied from [shiftInvoices].
@ProviderFor(shiftInvoices)
const shiftInvoicesProvider = ShiftInvoicesFamily();

/// Fetches all invoices for a given shift ID.
///
/// Copied from [shiftInvoices].
class ShiftInvoicesFamily extends Family<AsyncValue<List<Invoice>>> {
  /// Fetches all invoices for a given shift ID.
  ///
  /// Copied from [shiftInvoices].
  const ShiftInvoicesFamily();

  /// Fetches all invoices for a given shift ID.
  ///
  /// Copied from [shiftInvoices].
  ShiftInvoicesProvider call(int shiftId) {
    return ShiftInvoicesProvider(shiftId);
  }

  @override
  ShiftInvoicesProvider getProviderOverride(
    covariant ShiftInvoicesProvider provider,
  ) {
    return call(provider.shiftId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'shiftInvoicesProvider';
}

/// Fetches all invoices for a given shift ID.
///
/// Copied from [shiftInvoices].
class ShiftInvoicesProvider extends AutoDisposeFutureProvider<List<Invoice>> {
  /// Fetches all invoices for a given shift ID.
  ///
  /// Copied from [shiftInvoices].
  ShiftInvoicesProvider(int shiftId)
    : this._internal(
        (ref) => shiftInvoices(ref as ShiftInvoicesRef, shiftId),
        from: shiftInvoicesProvider,
        name: r'shiftInvoicesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$shiftInvoicesHash,
        dependencies: ShiftInvoicesFamily._dependencies,
        allTransitiveDependencies:
            ShiftInvoicesFamily._allTransitiveDependencies,
        shiftId: shiftId,
      );

  ShiftInvoicesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.shiftId,
  }) : super.internal();

  final int shiftId;

  @override
  Override overrideWith(
    FutureOr<List<Invoice>> Function(ShiftInvoicesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ShiftInvoicesProvider._internal(
        (ref) => create(ref as ShiftInvoicesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        shiftId: shiftId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Invoice>> createElement() {
    return _ShiftInvoicesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ShiftInvoicesProvider && other.shiftId == shiftId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, shiftId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ShiftInvoicesRef on AutoDisposeFutureProviderRef<List<Invoice>> {
  /// The parameter `shiftId` of this provider.
  int get shiftId;
}

class _ShiftInvoicesProviderElement
    extends AutoDisposeFutureProviderElement<List<Invoice>>
    with ShiftInvoicesRef {
  _ShiftInvoicesProviderElement(super.provider);

  @override
  int get shiftId => (origin as ShiftInvoicesProvider).shiftId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
