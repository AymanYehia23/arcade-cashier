// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tables_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tablesWithSessionsHash() =>
    r'4d3d066cfd20dc2c41a7822b04358ad7f1fd1cb3';

/// See also [tablesWithSessions].
@ProviderFor(tablesWithSessions)
final tablesWithSessionsProvider =
    AutoDisposeStreamProvider<List<TableWithSession>>.internal(
      tablesWithSessions,
      name: r'tablesWithSessionsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$tablesWithSessionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TablesWithSessionsRef =
    AutoDisposeStreamProviderRef<List<TableWithSession>>;
String _$tablesControllerHash() => r'8d63c27fcbcf74a89d513cc437d130ca97efb149';

/// See also [TablesController].
@ProviderFor(TablesController)
final tablesControllerProvider =
    AutoDisposeAsyncNotifierProvider<TablesController, void>.internal(
      TablesController.new,
      name: r'tablesControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$tablesControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TablesController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
