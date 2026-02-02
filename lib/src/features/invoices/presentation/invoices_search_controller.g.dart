// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoices_search_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$invoiceDateRangeHash() => r'1dc5ec1206a0c02b611faeb71a258047625af512';

/// See also [InvoiceDateRange].
@ProviderFor(InvoiceDateRange)
final invoiceDateRangeProvider =
    AutoDisposeNotifierProvider<InvoiceDateRange, DateTimeRange?>.internal(
      InvoiceDateRange.new,
      name: r'invoiceDateRangeProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$invoiceDateRangeHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$InvoiceDateRange = AutoDisposeNotifier<DateTimeRange?>;
String _$invoicesPaginationHash() =>
    r'41ab14c1c8bc3fcdeb7477f5c3623fdaefbc6841';

/// See also [InvoicesPagination].
@ProviderFor(InvoicesPagination)
final invoicesPaginationProvider =
    AutoDisposeAsyncNotifierProvider<
      InvoicesPagination,
      List<Invoice>
    >.internal(
      InvoicesPagination.new,
      name: r'invoicesPaginationProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$invoicesPaginationHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$InvoicesPagination = AutoDisposeAsyncNotifier<List<Invoice>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
