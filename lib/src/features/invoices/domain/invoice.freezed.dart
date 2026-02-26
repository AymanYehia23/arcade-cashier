// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Invoice _$InvoiceFromJson(Map<String, dynamic> json) {
  return _Invoice.fromJson(json);
}

/// @nodoc
mixin _$Invoice {
  @JsonKey(includeToJson: false)
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'session_id')
  int get sessionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_number')
  String get invoiceNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'shop_name')
  String get shopName => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_amount')
  double get totalAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method')
  String get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_amount')
  double get discountAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_percentage')
  double get discountPercentage => throw _privateConstructorUsedError;
  @JsonKey(name: 'issued_at')
  DateTime? get issuedAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'cancelled_at')
  DateTime? get cancelledAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_id')
  int? get customerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_name')
  String? get customerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'shift_id')
  int? get shiftId => throw _privateConstructorUsedError;

  /// Serializes this Invoice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvoiceCopyWith<Invoice> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceCopyWith<$Res> {
  factory $InvoiceCopyWith(Invoice value, $Res Function(Invoice) then) =
      _$InvoiceCopyWithImpl<$Res, Invoice>;
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int? id,
    @JsonKey(name: 'session_id') int sessionId,
    @JsonKey(name: 'invoice_number') String invoiceNumber,
    @JsonKey(name: 'shop_name') String shopName,
    @JsonKey(name: 'total_amount') double totalAmount,
    @JsonKey(name: 'payment_method') String paymentMethod,
    @JsonKey(name: 'discount_amount') double discountAmount,
    @JsonKey(name: 'discount_percentage') double discountPercentage,
    @JsonKey(name: 'issued_at') DateTime? issuedAt,
    String status,
    @JsonKey(name: 'cancelled_at') DateTime? cancelledAt,
    @JsonKey(name: 'customer_id') int? customerId,
    @JsonKey(name: 'customer_name') String? customerName,
    @JsonKey(name: 'shift_id') int? shiftId,
  });
}

/// @nodoc
class _$InvoiceCopyWithImpl<$Res, $Val extends Invoice>
    implements $InvoiceCopyWith<$Res> {
  _$InvoiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? sessionId = null,
    Object? invoiceNumber = null,
    Object? shopName = null,
    Object? totalAmount = null,
    Object? paymentMethod = null,
    Object? discountAmount = null,
    Object? discountPercentage = null,
    Object? issuedAt = freezed,
    Object? status = null,
    Object? cancelledAt = freezed,
    Object? customerId = freezed,
    Object? customerName = freezed,
    Object? shiftId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            sessionId: null == sessionId
                ? _value.sessionId
                : sessionId // ignore: cast_nullable_to_non_nullable
                      as int,
            invoiceNumber: null == invoiceNumber
                ? _value.invoiceNumber
                : invoiceNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            shopName: null == shopName
                ? _value.shopName
                : shopName // ignore: cast_nullable_to_non_nullable
                      as String,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            paymentMethod: null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as String,
            discountAmount: null == discountAmount
                ? _value.discountAmount
                : discountAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            discountPercentage: null == discountPercentage
                ? _value.discountPercentage
                : discountPercentage // ignore: cast_nullable_to_non_nullable
                      as double,
            issuedAt: freezed == issuedAt
                ? _value.issuedAt
                : issuedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            cancelledAt: freezed == cancelledAt
                ? _value.cancelledAt
                : cancelledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            customerId: freezed == customerId
                ? _value.customerId
                : customerId // ignore: cast_nullable_to_non_nullable
                      as int?,
            customerName: freezed == customerName
                ? _value.customerName
                : customerName // ignore: cast_nullable_to_non_nullable
                      as String?,
            shiftId: freezed == shiftId
                ? _value.shiftId
                : shiftId // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InvoiceImplCopyWith<$Res> implements $InvoiceCopyWith<$Res> {
  factory _$$InvoiceImplCopyWith(
    _$InvoiceImpl value,
    $Res Function(_$InvoiceImpl) then,
  ) = __$$InvoiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int? id,
    @JsonKey(name: 'session_id') int sessionId,
    @JsonKey(name: 'invoice_number') String invoiceNumber,
    @JsonKey(name: 'shop_name') String shopName,
    @JsonKey(name: 'total_amount') double totalAmount,
    @JsonKey(name: 'payment_method') String paymentMethod,
    @JsonKey(name: 'discount_amount') double discountAmount,
    @JsonKey(name: 'discount_percentage') double discountPercentage,
    @JsonKey(name: 'issued_at') DateTime? issuedAt,
    String status,
    @JsonKey(name: 'cancelled_at') DateTime? cancelledAt,
    @JsonKey(name: 'customer_id') int? customerId,
    @JsonKey(name: 'customer_name') String? customerName,
    @JsonKey(name: 'shift_id') int? shiftId,
  });
}

/// @nodoc
class __$$InvoiceImplCopyWithImpl<$Res>
    extends _$InvoiceCopyWithImpl<$Res, _$InvoiceImpl>
    implements _$$InvoiceImplCopyWith<$Res> {
  __$$InvoiceImplCopyWithImpl(
    _$InvoiceImpl _value,
    $Res Function(_$InvoiceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? sessionId = null,
    Object? invoiceNumber = null,
    Object? shopName = null,
    Object? totalAmount = null,
    Object? paymentMethod = null,
    Object? discountAmount = null,
    Object? discountPercentage = null,
    Object? issuedAt = freezed,
    Object? status = null,
    Object? cancelledAt = freezed,
    Object? customerId = freezed,
    Object? customerName = freezed,
    Object? shiftId = freezed,
  }) {
    return _then(
      _$InvoiceImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        sessionId: null == sessionId
            ? _value.sessionId
            : sessionId // ignore: cast_nullable_to_non_nullable
                  as int,
        invoiceNumber: null == invoiceNumber
            ? _value.invoiceNumber
            : invoiceNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        shopName: null == shopName
            ? _value.shopName
            : shopName // ignore: cast_nullable_to_non_nullable
                  as String,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        paymentMethod: null == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as String,
        discountAmount: null == discountAmount
            ? _value.discountAmount
            : discountAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        discountPercentage: null == discountPercentage
            ? _value.discountPercentage
            : discountPercentage // ignore: cast_nullable_to_non_nullable
                  as double,
        issuedAt: freezed == issuedAt
            ? _value.issuedAt
            : issuedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        cancelledAt: freezed == cancelledAt
            ? _value.cancelledAt
            : cancelledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        customerId: freezed == customerId
            ? _value.customerId
            : customerId // ignore: cast_nullable_to_non_nullable
                  as int?,
        customerName: freezed == customerName
            ? _value.customerName
            : customerName // ignore: cast_nullable_to_non_nullable
                  as String?,
        shiftId: freezed == shiftId
            ? _value.shiftId
            : shiftId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoiceImpl extends _Invoice {
  const _$InvoiceImpl({
    @JsonKey(includeToJson: false) this.id,
    @JsonKey(name: 'session_id') required this.sessionId,
    @JsonKey(name: 'invoice_number') required this.invoiceNumber,
    @JsonKey(name: 'shop_name') required this.shopName,
    @JsonKey(name: 'total_amount') required this.totalAmount,
    @JsonKey(name: 'payment_method') this.paymentMethod = 'cash',
    @JsonKey(name: 'discount_amount') this.discountAmount = 0.0,
    @JsonKey(name: 'discount_percentage') this.discountPercentage = 0.0,
    @JsonKey(name: 'issued_at') this.issuedAt,
    this.status = 'paid',
    @JsonKey(name: 'cancelled_at') this.cancelledAt,
    @JsonKey(name: 'customer_id') this.customerId,
    @JsonKey(name: 'customer_name') this.customerName,
    @JsonKey(name: 'shift_id') this.shiftId,
  }) : super._();

  factory _$InvoiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int? id;
  @override
  @JsonKey(name: 'session_id')
  final int sessionId;
  @override
  @JsonKey(name: 'invoice_number')
  final String invoiceNumber;
  @override
  @JsonKey(name: 'shop_name')
  final String shopName;
  @override
  @JsonKey(name: 'total_amount')
  final double totalAmount;
  @override
  @JsonKey(name: 'payment_method')
  final String paymentMethod;
  @override
  @JsonKey(name: 'discount_amount')
  final double discountAmount;
  @override
  @JsonKey(name: 'discount_percentage')
  final double discountPercentage;
  @override
  @JsonKey(name: 'issued_at')
  final DateTime? issuedAt;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'cancelled_at')
  final DateTime? cancelledAt;
  @override
  @JsonKey(name: 'customer_id')
  final int? customerId;
  @override
  @JsonKey(name: 'customer_name')
  final String? customerName;
  @override
  @JsonKey(name: 'shift_id')
  final int? shiftId;

  @override
  String toString() {
    return 'Invoice(id: $id, sessionId: $sessionId, invoiceNumber: $invoiceNumber, shopName: $shopName, totalAmount: $totalAmount, paymentMethod: $paymentMethod, discountAmount: $discountAmount, discountPercentage: $discountPercentage, issuedAt: $issuedAt, status: $status, cancelledAt: $cancelledAt, customerId: $customerId, customerName: $customerName, shiftId: $shiftId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.invoiceNumber, invoiceNumber) ||
                other.invoiceNumber == invoiceNumber) &&
            (identical(other.shopName, shopName) ||
                other.shopName == shopName) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.discountPercentage, discountPercentage) ||
                other.discountPercentage == discountPercentage) &&
            (identical(other.issuedAt, issuedAt) ||
                other.issuedAt == issuedAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    sessionId,
    invoiceNumber,
    shopName,
    totalAmount,
    paymentMethod,
    discountAmount,
    discountPercentage,
    issuedAt,
    status,
    cancelledAt,
    customerId,
    customerName,
    shiftId,
  );

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceImplCopyWith<_$InvoiceImpl> get copyWith =>
      __$$InvoiceImplCopyWithImpl<_$InvoiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceImplToJson(this);
  }
}

abstract class _Invoice extends Invoice {
  const factory _Invoice({
    @JsonKey(includeToJson: false) final int? id,
    @JsonKey(name: 'session_id') required final int sessionId,
    @JsonKey(name: 'invoice_number') required final String invoiceNumber,
    @JsonKey(name: 'shop_name') required final String shopName,
    @JsonKey(name: 'total_amount') required final double totalAmount,
    @JsonKey(name: 'payment_method') final String paymentMethod,
    @JsonKey(name: 'discount_amount') final double discountAmount,
    @JsonKey(name: 'discount_percentage') final double discountPercentage,
    @JsonKey(name: 'issued_at') final DateTime? issuedAt,
    final String status,
    @JsonKey(name: 'cancelled_at') final DateTime? cancelledAt,
    @JsonKey(name: 'customer_id') final int? customerId,
    @JsonKey(name: 'customer_name') final String? customerName,
    @JsonKey(name: 'shift_id') final int? shiftId,
  }) = _$InvoiceImpl;
  const _Invoice._() : super._();

  factory _Invoice.fromJson(Map<String, dynamic> json) = _$InvoiceImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  int? get id;
  @override
  @JsonKey(name: 'session_id')
  int get sessionId;
  @override
  @JsonKey(name: 'invoice_number')
  String get invoiceNumber;
  @override
  @JsonKey(name: 'shop_name')
  String get shopName;
  @override
  @JsonKey(name: 'total_amount')
  double get totalAmount;
  @override
  @JsonKey(name: 'payment_method')
  String get paymentMethod;
  @override
  @JsonKey(name: 'discount_amount')
  double get discountAmount;
  @override
  @JsonKey(name: 'discount_percentage')
  double get discountPercentage;
  @override
  @JsonKey(name: 'issued_at')
  DateTime? get issuedAt;
  @override
  String get status;
  @override
  @JsonKey(name: 'cancelled_at')
  DateTime? get cancelledAt;
  @override
  @JsonKey(name: 'customer_id')
  int? get customerId;
  @override
  @JsonKey(name: 'customer_name')
  String? get customerName;
  @override
  @JsonKey(name: 'shift_id')
  int? get shiftId;

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvoiceImplCopyWith<_$InvoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
