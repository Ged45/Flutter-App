import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../home/services/home_service.dart';
import '../widgets/amount_field.dart';
import '../widgets/categoriy_grid.dart';
import '../widgets/label.dart';
import '../widgets/text_field.dart';

class EditExpenseScreen extends StatefulWidget {
  final Map<String, dynamic> expense;

  const EditExpenseScreen({
    super.key,
    required this.expense,
  });

  @override
  State<EditExpenseScreen> createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
  late String selectedCategory;
  late TextEditingController amountCtrl;
  late TextEditingController descriptionCtrl;
  late TextEditingController storeCtrl;

  bool isLoading = false;

  final categories = const [
    ('Food', '🍔'),
    ('Travel', '✈️'),
    ('Entertainment', '🎬'),
    ('Shopping', '🛒'),
    ('Health', '🩺'),
    ('Utility', '💧'),
  ];

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.expense['category'];
    amountCtrl = TextEditingController(
        text: widget.expense['amount'].toString());
    descriptionCtrl =
        TextEditingController(text: widget.expense['description'] ?? '');
    storeCtrl =
        TextEditingController(text: widget.expense['store'] ?? '');
  }

  @override
  void dispose() {
    amountCtrl.dispose();
    descriptionCtrl.dispose();
    storeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Expense'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label('Amount'),
              amountField(
                controller: amountCtrl,
              ),

              const SizedBox(height: 24),
              label('Category'),
              const SizedBox(height: 12),
              CategoryGrid(
                categories: categories,
                selectedCategory: selectedCategory,
                onCategorySelected: (value) {
                  setState(() => selectedCategory = value);
                },
              ),

              const SizedBox(height: 24),
              label('Description'),
              textField(
                controller: descriptionCtrl,
                hint: 'What did you buy?',
              ),

              const SizedBox(height: 24),
              label('Store (optional)'),
              textField(
                controller: storeCtrl,
                hint: 'Where did you shop?',
              ),

              const SizedBox(height: 32),
_saveButton(),
TextButton(
  onPressed: () {
    deleteExpense(widget.expense['id']);
  },
  child: const Text(
    'Delete Expense',
    style: TextStyle(color: Colors.red),
  ),
),

            ],
          ),
        ),
      ),
    );
  }

  Widget _saveButton() => SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: isLoading
              ? null
              : () {
                  updateExpense(
                    id: widget.expense['id'],
                    amount: double.tryParse(amountCtrl.text) ?? 0,
                    category: selectedCategory,
                    description: descriptionCtrl.text,
                    store: storeCtrl.text,
                  );
                },
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text('Save Changes'),
        ),
      );

  

}
