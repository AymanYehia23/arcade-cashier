import 'package:arcade_cashier/src/core/supabase_provider.dart';
import 'package:arcade_cashier/src/features/invoices/domain/invoice.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'invoices_repository.g.dart';

abstract class InvoicesRepository {
  Future<Invoice> createInvoice(Invoice invoice);
  Stream<List<Invoice>> watchInvoiceHistory();
  Future<List<Invoice>> fetchInvoices({
    DateTime? startDate,
    DateTime? endDate,
    int page = 0,
    int pageSize = 20,
  });
  Future<Invoice?> getInvoiceById(int id);
  Future<String> generateInvoiceNumber();
}

class SupabaseInvoicesRepository implements InvoicesRepository {
  final SupabaseClient _supabase;

  SupabaseInvoicesRepository(this._supabase);

  @override
  Future<Invoice> createInvoice(Invoice invoice) async {
    final data = await _supabase
        .from('invoices')
        .insert(invoice.toJson())
        .select()
        .single();

    return Invoice.fromJson(data);
  }

  @override
  Stream<List<Invoice>> watchInvoiceHistory() {
    return _supabase
        .from('invoices')
        .stream(primaryKey: ['id'])
        .order('issued_at', ascending: false)
        .map((data) => data.map((e) => Invoice.fromJson(e)).toList());
  }

  @override
  Future<Invoice?> getInvoiceById(int id) async {
    final data = await _supabase
        .from('invoices')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (data == null) return null;
    return Invoice.fromJson(data);
  }

  @override
  Future<List<Invoice>> fetchInvoices({
    DateTime? startDate,
    DateTime? endDate,
    int page = 0,
    int pageSize = 20,
  }) async {
    var query = _supabase.from('invoices').select();

    if (startDate != null) {
      query = query.gte('issued_at', startDate.toIso8601String());
    }
    if (endDate != null) {
      query = query.lte('issued_at', endDate.toIso8601String());
    }

    final data = await query
        .order('issued_at', ascending: false)
        .range(page * pageSize, (page + 1) * pageSize - 1);

    return (data as List).map((e) => Invoice.fromJson(e)).toList();
  }

  @override
  Future<String> generateInvoiceNumber() async {
    final now = DateTime.now();
    final datePrefix =
        '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';

    // Get today's invoice count
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final response = await _supabase
        .from('invoices')
        .select('id')
        .gte('issued_at', startOfDay.toUtc().toIso8601String())
        .lt('issued_at', endOfDay.toUtc().toIso8601String());

    final count = (response as List).length + 1;
    return 'INV-$datePrefix-${count.toString().padLeft(3, '0')}';
  }
}

@Riverpod(keepAlive: true)
InvoicesRepository invoicesRepository(Ref ref) {
  return SupabaseInvoicesRepository(ref.watch(supabaseProvider));
}
