// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvoiceImpl _$$InvoiceImplFromJson(Map<String, dynamic> json) =>
    _$InvoiceImpl(
      id: (json['id'] as num?)?.toInt(),
      sessionId: (json['session_id'] as num).toInt(),
      invoiceNumber: json['invoice_number'] as String,
      shopName: json['shop_name'] as String,
      totalAmount: (json['total_amount'] as num).toDouble(),
      paymentMethod: json['payment_method'] as String? ?? 'cash',
      discountAmount: (json['discount_amount'] as num?)?.toDouble() ?? 0.0,
      discountPercentage:
          (json['discount_percentage'] as num?)?.toDouble() ?? 0.0,
      issuedAt: json['issued_at'] == null
          ? null
          : DateTime.parse(json['issued_at'] as String),
      status: json['status'] as String? ?? 'paid',
      cancelledAt: json['cancelled_at'] == null
          ? null
          : DateTime.parse(json['cancelled_at'] as String),
      customerId: (json['customer_id'] as num?)?.toInt(),
      customerName: json['customer_name'] as String?,
    );

Map<String, dynamic> _$$InvoiceImplToJson(_$InvoiceImpl instance) =>
    <String, dynamic>{
      'session_id': instance.sessionId,
      'invoice_number': instance.invoiceNumber,
      'shop_name': instance.shopName,
      'total_amount': instance.totalAmount,
      'payment_method': instance.paymentMethod,
      'discount_amount': instance.discountAmount,
      'discount_percentage': instance.discountPercentage,
      'issued_at': instance.issuedAt?.toIso8601String(),
      'status': instance.status,
      'cancelled_at': instance.cancelledAt?.toIso8601String(),
      'customer_id': instance.customerId,
      'customer_name': instance.customerName,
    };
