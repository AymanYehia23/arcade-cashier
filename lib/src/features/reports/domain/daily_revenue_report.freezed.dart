// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_revenue_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DailyRevenueReport _$DailyRevenueReportFromJson(Map<String, dynamic> json) {
  return _DailyRevenueReport.fromJson(json);
}

/// @nodoc
mixin _$DailyRevenueReport {
  @JsonKey(name: 'report_date')
  DateTime get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'net_revenue')
  double get netRevenue => throw _privateConstructorUsedError;
  @JsonKey(name: 'gross_revenue')
  double get grossRevenue => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_discount')
  double get totalDiscount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_invoices')
  int get invoiceCount => throw _privateConstructorUsedError;

  /// Serializes this DailyRevenueReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyRevenueReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyRevenueReportCopyWith<DailyRevenueReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyRevenueReportCopyWith<$Res> {
  factory $DailyRevenueReportCopyWith(
    DailyRevenueReport value,
    $Res Function(DailyRevenueReport) then,
  ) = _$DailyRevenueReportCopyWithImpl<$Res, DailyRevenueReport>;
  @useResult
  $Res call({
    @JsonKey(name: 'report_date') DateTime date,
    @JsonKey(name: 'net_revenue') double netRevenue,
    @JsonKey(name: 'gross_revenue') double grossRevenue,
    @JsonKey(name: 'total_discount') double totalDiscount,
    @JsonKey(name: 'total_invoices') int invoiceCount,
  });
}

/// @nodoc
class _$DailyRevenueReportCopyWithImpl<$Res, $Val extends DailyRevenueReport>
    implements $DailyRevenueReportCopyWith<$Res> {
  _$DailyRevenueReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyRevenueReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? netRevenue = null,
    Object? grossRevenue = null,
    Object? totalDiscount = null,
    Object? invoiceCount = null,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            netRevenue: null == netRevenue
                ? _value.netRevenue
                : netRevenue // ignore: cast_nullable_to_non_nullable
                      as double,
            grossRevenue: null == grossRevenue
                ? _value.grossRevenue
                : grossRevenue // ignore: cast_nullable_to_non_nullable
                      as double,
            totalDiscount: null == totalDiscount
                ? _value.totalDiscount
                : totalDiscount // ignore: cast_nullable_to_non_nullable
                      as double,
            invoiceCount: null == invoiceCount
                ? _value.invoiceCount
                : invoiceCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DailyRevenueReportImplCopyWith<$Res>
    implements $DailyRevenueReportCopyWith<$Res> {
  factory _$$DailyRevenueReportImplCopyWith(
    _$DailyRevenueReportImpl value,
    $Res Function(_$DailyRevenueReportImpl) then,
  ) = __$$DailyRevenueReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'report_date') DateTime date,
    @JsonKey(name: 'net_revenue') double netRevenue,
    @JsonKey(name: 'gross_revenue') double grossRevenue,
    @JsonKey(name: 'total_discount') double totalDiscount,
    @JsonKey(name: 'total_invoices') int invoiceCount,
  });
}

/// @nodoc
class __$$DailyRevenueReportImplCopyWithImpl<$Res>
    extends _$DailyRevenueReportCopyWithImpl<$Res, _$DailyRevenueReportImpl>
    implements _$$DailyRevenueReportImplCopyWith<$Res> {
  __$$DailyRevenueReportImplCopyWithImpl(
    _$DailyRevenueReportImpl _value,
    $Res Function(_$DailyRevenueReportImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailyRevenueReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? netRevenue = null,
    Object? grossRevenue = null,
    Object? totalDiscount = null,
    Object? invoiceCount = null,
  }) {
    return _then(
      _$DailyRevenueReportImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        netRevenue: null == netRevenue
            ? _value.netRevenue
            : netRevenue // ignore: cast_nullable_to_non_nullable
                  as double,
        grossRevenue: null == grossRevenue
            ? _value.grossRevenue
            : grossRevenue // ignore: cast_nullable_to_non_nullable
                  as double,
        totalDiscount: null == totalDiscount
            ? _value.totalDiscount
            : totalDiscount // ignore: cast_nullable_to_non_nullable
                  as double,
        invoiceCount: null == invoiceCount
            ? _value.invoiceCount
            : invoiceCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyRevenueReportImpl implements _DailyRevenueReport {
  const _$DailyRevenueReportImpl({
    @JsonKey(name: 'report_date') required this.date,
    @JsonKey(name: 'net_revenue') required this.netRevenue,
    @JsonKey(name: 'gross_revenue') required this.grossRevenue,
    @JsonKey(name: 'total_discount') required this.totalDiscount,
    @JsonKey(name: 'total_invoices') required this.invoiceCount,
  });

  factory _$DailyRevenueReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyRevenueReportImplFromJson(json);

  @override
  @JsonKey(name: 'report_date')
  final DateTime date;
  @override
  @JsonKey(name: 'net_revenue')
  final double netRevenue;
  @override
  @JsonKey(name: 'gross_revenue')
  final double grossRevenue;
  @override
  @JsonKey(name: 'total_discount')
  final double totalDiscount;
  @override
  @JsonKey(name: 'total_invoices')
  final int invoiceCount;

  @override
  String toString() {
    return 'DailyRevenueReport(date: $date, netRevenue: $netRevenue, grossRevenue: $grossRevenue, totalDiscount: $totalDiscount, invoiceCount: $invoiceCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyRevenueReportImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.netRevenue, netRevenue) ||
                other.netRevenue == netRevenue) &&
            (identical(other.grossRevenue, grossRevenue) ||
                other.grossRevenue == grossRevenue) &&
            (identical(other.totalDiscount, totalDiscount) ||
                other.totalDiscount == totalDiscount) &&
            (identical(other.invoiceCount, invoiceCount) ||
                other.invoiceCount == invoiceCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    netRevenue,
    grossRevenue,
    totalDiscount,
    invoiceCount,
  );

  /// Create a copy of DailyRevenueReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyRevenueReportImplCopyWith<_$DailyRevenueReportImpl> get copyWith =>
      __$$DailyRevenueReportImplCopyWithImpl<_$DailyRevenueReportImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyRevenueReportImplToJson(this);
  }
}

abstract class _DailyRevenueReport implements DailyRevenueReport {
  const factory _DailyRevenueReport({
    @JsonKey(name: 'report_date') required final DateTime date,
    @JsonKey(name: 'net_revenue') required final double netRevenue,
    @JsonKey(name: 'gross_revenue') required final double grossRevenue,
    @JsonKey(name: 'total_discount') required final double totalDiscount,
    @JsonKey(name: 'total_invoices') required final int invoiceCount,
  }) = _$DailyRevenueReportImpl;

  factory _DailyRevenueReport.fromJson(Map<String, dynamic> json) =
      _$DailyRevenueReportImpl.fromJson;

  @override
  @JsonKey(name: 'report_date')
  DateTime get date;
  @override
  @JsonKey(name: 'net_revenue')
  double get netRevenue;
  @override
  @JsonKey(name: 'gross_revenue')
  double get grossRevenue;
  @override
  @JsonKey(name: 'total_discount')
  double get totalDiscount;
  @override
  @JsonKey(name: 'total_invoices')
  int get invoiceCount;

  /// Create a copy of DailyRevenueReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyRevenueReportImplCopyWith<_$DailyRevenueReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
