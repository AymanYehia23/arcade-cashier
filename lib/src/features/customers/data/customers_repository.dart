import 'package:arcade_cashier/src/constants/db_constants.dart';
import 'package:arcade_cashier/src/core/supabase_provider.dart';
import 'package:arcade_cashier/src/features/customers/domain/customer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'customers_repository.g.dart';

abstract class CustomersRepository {
  Future<List<Customer>> searchCustomers(String query);
  Future<Customer> createCustomer({required String name, String? phone});
}

class SupabaseCustomersRepository implements CustomersRepository {
  final SupabaseClient _supabase;

  SupabaseCustomersRepository(this._supabase);

  @override
  Future<List<Customer>> searchCustomers(String query) async {
    if (query.trim().isEmpty) return [];

    final response = await _supabase
        .from('customers') // Assuming table name is 'customers'
        .select()
        .or('name.ilike.%$query%,phone.ilike.%$query%')
        .limit(10);

    return (response as List).map((e) => Customer.fromJson(e)).toList();
  }

  @override
  Future<Customer> createCustomer({required String name, String? phone}) async {
    final response = await _supabase
        .from('customers')
        .insert({'name': name, 'phone': phone})
        .select()
        .single();

    return Customer.fromJson(response);
  }
}

@Riverpod(keepAlive: true)
CustomersRepository customersRepository(Ref ref) {
  return SupabaseCustomersRepository(ref.watch(supabaseProvider));
}
