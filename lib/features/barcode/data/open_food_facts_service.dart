import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenFoodFactsService {
  static const _baseUrl =
      'https://world.openfoodfacts.org/api/v0/product';

  Future<Map<String, dynamic>?> fetchByBarcode(String barcode) async {
    final url = Uri.parse('$_baseUrl/$barcode.json');

    final response = await http.get(url);

    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body);

    if (data['status'] != 1) return null;

    final product = data['product'];

    return {
      'barcode': barcode,
      'name': product['product_name'] ??
          product['brands'] ??
          'Unknown Product',
      'category': _extractCategory(product),
    };
  }

  String? _extractCategory(Map product) {
    final categories = product['categories_tags'];
    if (categories is List && categories.isNotEmpty) {
      return categories.first.toString().replaceAll('en:', '');
    }
    return null;
  }

  static Future<dynamic> search(String query) async {}
}
