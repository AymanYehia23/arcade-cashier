// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productsHash() => r'0da3e18cdc864942be1f427f01fa5d59b368e655';

/// See also [products].
@ProviderFor(products)
final productsProvider = AutoDisposeStreamProvider<List<Product>>.internal(
  products,
  name: r'productsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductsRef = AutoDisposeStreamProviderRef<List<Product>>;
String _$productFormControllerHash() =>
    r'790dcea9a429b9d6718d2b7a98196772fecffb67';

/// See also [ProductFormController].
@ProviderFor(ProductFormController)
final productFormControllerProvider =
    AutoDisposeAsyncNotifierProvider<ProductFormController, void>.internal(
      ProductFormController.new,
      name: r'productFormControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$productFormControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ProductFormController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
