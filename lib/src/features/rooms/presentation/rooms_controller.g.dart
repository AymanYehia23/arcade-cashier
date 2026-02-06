// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rooms_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$roomsWithSessionsHash() => r'bc073226d0d2feb4d1c46bd426393baf82f11519';

/// See also [roomsWithSessions].
@ProviderFor(roomsWithSessions)
final roomsWithSessionsProvider =
    AutoDisposeStreamProvider<List<RoomWithSession>>.internal(
      roomsWithSessions,
      name: r'roomsWithSessionsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$roomsWithSessionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RoomsWithSessionsRef =
    AutoDisposeStreamProviderRef<List<RoomWithSession>>;
String _$roomsControllerHash() => r'f65a16853b3da03b646ddb8ece5a0aabc3166172';

/// See also [RoomsController].
@ProviderFor(RoomsController)
final roomsControllerProvider =
    AutoDisposeAsyncNotifierProvider<RoomsController, void>.internal(
      RoomsController.new,
      name: r'roomsControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$roomsControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$RoomsController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
