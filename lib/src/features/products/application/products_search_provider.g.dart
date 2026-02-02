// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_search_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredProductsHash() => r'24567e806cc5144610ee1d41167521c4b5b7104a';

/// See also [filteredProducts].
@ProviderFor(filteredProducts)
final filteredProductsProvider =
    AutoDisposeProvider<AsyncValue<List<Product>>>.internal(
      filteredProducts,
      name: r'filteredProductsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$filteredProductsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredProductsRef = AutoDisposeProviderRef<AsyncValue<List<Product>>>;
String _$productSearchQueryHash() =>
    r'95cb84da1faf175f02cfdb3bc661b446eccf1d02';

/// See also [ProductSearchQuery].
@ProviderFor(ProductSearchQuery)
final productSearchQueryProvider =
    AutoDisposeNotifierProvider<ProductSearchQuery, String>.internal(
      ProductSearchQuery.new,
      name: r'productSearchQueryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$productSearchQueryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ProductSearchQuery = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
