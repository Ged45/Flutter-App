import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepository {
  final _client = Supabase.instance.client;

  Future<Map<String, dynamic>?> findByBarcode(String barcode) async {
    final response = await _client
        .from('products')
        .select()
        .eq('barcode', barcode)
        .maybeSingle();

    return response;
  }

  Future<void> insertProduct(Map<String, dynamic> product) async {
  await _client.from('products').insert({
    'barcode': product['barcode'],
    'name': product['name'],
    'category': product['category'],
  });
}



  
}

