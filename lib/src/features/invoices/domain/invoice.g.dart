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
      issuedAt: json['issued_at'] == null
          ? null
          : DateTime.parse(json['issued_at'] as String),
    );

Map<String, dynamic> _$$InvoiceImplToJson(_$InvoiceImpl instance) =>
    <String, dynamic>{
      'session_id': instance.sessionId,
      'invoice_number': instance.invoiceNumber,
      'shop_name': instance.shopName,
      'total_amount': instance.totalAmount,
      'payment_method': instance.paymentMethod,
      'issued_at': instance.issuedAt?.toIso8601String(),
    };
