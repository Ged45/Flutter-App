import'package:flutter/material.dart';
 Map<String, dynamic>? scannedProduct;

Widget noResultsCard() => Container(
  padding: const EdgeInsets.all(24),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
  ),
  child: const Text('No product found'),
);

Widget productResultCard() { 

  final bool isFromApi = scannedProduct!['id'] == null;
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
    borderRadius: BorderRadius.circular(20),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        scannedProduct!['name'],
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      Text('Category: ${scannedProduct!['category'] ?? 'Unknown'}'),
      Text('Avg price: ${scannedProduct!['avg_price'] ?? '--'} Birr'),
      const SizedBox(height: 12),
      if (isFromApi)
  const Text(
    'Source: OpenFoodFacts',
    style: TextStyle(fontSize: 12, color: Colors.grey),
  ),

      ElevatedButton(
        onPressed: () {
          // open AddExpenseScreen with prefilled data 
        },
        child: const Text('Add as Expense'),
      )
    ],
  ),
);
}