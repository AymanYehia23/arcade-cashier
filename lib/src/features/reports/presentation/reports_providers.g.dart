// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dailyRevenueHash() => r'b3c1e51272b221c571a11feaf1a6e2d8f8744e80';

/// See also [dailyRevenue].
@ProviderFor(dailyRevenue)
final dailyRevenueProvider =
    AutoDisposeFutureProvider<List<DailyRevenueReport>>.internal(
      dailyRevenue,
      name: r'dailyRevenueProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$dailyRevenueHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DailyRevenueRef =
    AutoDisposeFutureProviderRef<List<DailyRevenueReport>>;
String _$topProductsHash() => r'd0cff8953c332cf6edab873ea958f228a20b0cd5';

/// See also [topProducts].
@ProviderFor(topProducts)
final topProductsProvider =
    AutoDisposeFutureProvider<List<ProductPerformanceReport>>.internal(
      topProducts,
      name: r'topProductsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$topProductsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TopProductsRef =
    AutoDisposeFutureProviderRef<List<ProductPerformanceReport>>;
String _$roomUsageHash() => r'77b75222feddb7641840d7e4fd45772be42fefb8';

/// See also [roomUsage].
@ProviderFor(roomUsage)
final roomUsageProvider =
    AutoDisposeFutureProvider<List<RoomUsageReport>>.internal(
      roomUsage,
      name: r'roomUsageProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$roomUsageHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RoomUsageRef = AutoDisposeFutureProviderRef<List<RoomUsageReport>>;
String _$dateRangeFilterHash() => r'a977ca18449dac9a3cf40938b2dc45954d1b33fd';

/// See also [DateRangeFilter].
@ProviderFor(DateRangeFilter)
final dateRangeFilterProvider =
    AutoDisposeNotifierProvider<DateRangeFilter, DateTimeRange>.internal(
      DateRangeFilter.new,
      name: r'dateRangeFilterProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$dateRangeFilterHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DateRangeFilter = AutoDisposeNotifier<DateTimeRange>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
