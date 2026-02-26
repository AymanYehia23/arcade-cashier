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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
