import 'package:arcade_cashier/src/constants/db_constants.dart';
import 'package:arcade_cashier/src/features/products/data/products_repository.dart';
import 'package:arcade_cashier/src/features/products/domain/product.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProductsRepository implements ProductsRepository {
  final SupabaseClient _supabase;

  SupabaseProductsRepository(this._supabase);

  @override
  Stream<List<Product>> watchProducts() {
    return _supabase
        .from(DbTables.products)
        .stream(primaryKey: ['id'])
        .eq('is_active', true)
        .order('category', ascending: true)
        .order('name', ascending: true)
        .map((data) => data.map((json) => Product.fromJson(json)).toList());
  }

  @override
  Future<void> createProduct(Product product) async {
    await _supabase.from(DbTables.products).insert({
      'name': product.name,
      'category': product.category,
      'selling_price': product.sellingPrice,
      'stock_quantity': product.stockQuantity,
      'is_active': true,
    });
  }

  @override
  Future<void> updateProduct(Product product) async {
    await _supabase
        .from(DbTables.products)
        .update({
          'name': product.name,
          'category': product.category,
          'selling_price': product.sellingPrice,
          'stock_quantity': product.stockQuantity,
        })
        .eq('id', product.id);
  }

  @override
  Future<void> deleteProduct(int id) async {
    await _supabase
        .from(DbTables.products)
        .update({'is_active': false})
        .eq('id', id);
  }
}
