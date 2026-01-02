import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import '../../expenses/widgets/bottom_nav.dart';
import '../../../route/app_router.dart';
import '../../expenses/widgets/app_bar.dart';
import '../../home/widget/add_button.dart';
import '../../barcode/data/product_repository.dart';
import '../../barcode/screens/scanner.dart';
import '../../barcode/widgets/cards.dart';
import'../../barcode/data/open_food_facts_service.dart';
import '../../expenses/screens/add_expense_screen.dart';
class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
   final TextEditingController _searchCtrl = TextEditingController();
Timer? _debounce;


List<Map<String, dynamic>> results = [];

   Map<String, dynamic>? scannedProduct;
bool isScanning = false;
bool isLoading = false;

void _openScanner() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const BarcodeScannerScreen(),
    ),
  ).then((barcode) {
    if (barcode != null) {
      _lookupProduct(barcode);
    }
  });
}
Future<void> _lookupProduct(String barcode) async {
  setState(() {
    isLoading = true;
    scannedProduct = null;
  });

  final repo = ProductRepository();

  ///Try Supabase
  final localProduct = await repo.findByBarcode(barcode);

  if (localProduct != null) {
    setState(() {
      scannedProduct = localProduct;
      isLoading = false;
    });
    return;
  }

  ///  Fallback to OpenFoodFacts
  final apiProduct =
      await OpenFoodFactsService().fetchByBarcode(barcode);

  if (apiProduct != null) {
    /// Save for future scans
    await repo.insertProduct(apiProduct);

    setState(() {
      scannedProduct = apiProduct;
      isLoading = false;
    });
    return;
  }

  ///  Nothing found
  setState(() {
    isLoading = false;
  });
}
void _onSearchChanged(String query) {
  if (_debounce?.isActive ?? false) _debounce!.cancel();

  _debounce = Timer(const Duration(milliseconds: 400), () {
    if (query.trim().length < 2) {
      setState(() => results.clear());
      return;
    }
    _searchProducts(query.trim());
  });
}

Future<void> _searchProducts(String query) async {
  setState(() => isLoading = true);

  /// 1️⃣ Search Supabase first
  final dbResults = await Supabase.instance.client
      .from('products')
      .select()
      .ilike('name', '%$query%')
      .limit(10);

  if (dbResults.isNotEmpty) {
    setState(() {
      results = List<Map<String, dynamic>>.from(dbResults);
      isLoading = false;
    });
    return;
  }

  /// 2️⃣ Fallback → OpenFoodFacts
  final apiResults = await OpenFoodFactsService.search(query);

  setState(() {
    results = apiResults;
    isLoading = false;
  });
}

@override
void dispose() {
  _debounce?.cancel();
  _searchCtrl.dispose();
  super.dispose();
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: const SmartSpendHeader(subtitle: "Scan"),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 1,
        onTap: (index) => handleNav(context, index),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Scan Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  /// Dashed Scan Area
                  GestureDetector(
                    onTap: _openScanner,
                      // Handle barcode scanning logic here
            
                    child:
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.redAccent,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE6F3FF),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.qr_code_scanner,
                              color: Colors.redAccent,
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Scan Barcode",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Tap to scan product",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),),

                  const SizedBox(height: 20),

                  /// OR Divider
                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "OR",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// Search Field
                  TextField(
                    controller: _searchCtrl,
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                      hintText: "Search product",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        _lookupProduct(value);
                      }
                    },

                  ),
          if (isLoading)
  const Padding(
    padding: EdgeInsets.all(12),
    child: CircularProgressIndicator(),
  ),

if (results.isNotEmpty)
  ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: results.length,
    separatorBuilder: (_, __) => const Divider(),
    itemBuilder: (context, index) {
      final p = results[index];
      final isFromApi = p['id'] == null;

      return ListTile(
        leading: const Icon(Icons.shopping_bag),
        title: Text(p['name']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (p['category'] != null) Text(p['category']),
            if (isFromApi)
              const Text(
                'Source: OpenFoodFacts',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddExpenseScreen(
                presetProduct: p,
              ),
            ),
          );
        },
      );
    },
  ),

                  

                ],
              ),
            ),

            const SizedBox(height: 20),

            /// No Results Card
            if (isLoading)
  const CircularProgressIndicator()
else if (scannedProduct == null)
  noResultsCard()
else
  productResultCard(),

          ],
        ),
      ),

      /// Floating Add Button
      floatingActionButton: AddButton(),

    );
  }
}
