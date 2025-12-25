import 'package:flutter/material.dart';
import '../widgets/amount_field.dart';
import '../widgets/categoriy_grid.dart';
import '../widgets/label.dart';
import '../widgets/submit_button.dart';
import '../widgets/text_field.dart';


class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  String selectedCategory = 'Food';

  final amountCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final storeCtrl = TextEditingController();

  final categories = const [
    ('Food', '🍔'),
    ('Travel', '✈️'),
    ('Entertainment', '🎬'),
    ('Shopping', '🛒'),
    ('Health', '🩺'),
    ('Utility', '💧'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF1F6FF),
              Color(0xFFFFEEF4),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label('Amount'),
                amountField(),

                const SizedBox(height: 24),
                label('Category'),
                const SizedBox(height: 12),
                categoryGrid(),

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
                submitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ───────────────────────── Widgets ─────────────────────────
  Widget submitButton() => SizedBox(
        width: double.infinity,
        height: 56,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4A7DFF), Color(0xFF7B4DFF)],
            ),
            borderRadius: BorderRadius.circular(28),
          ),
          child: ElevatedButton(
            onPressed: submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: const Text(
              'Add Expense',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );


  




  // ───────────────────────── Logic ─────────────────────────

   
void submit() {
    final amount = double.tryParse(amountCtrl.text);

    if (amount == null || amount <= 0) return;

    // TODO: connect to Supabase insert
    debugPrint({
      'amount': amount,
      'category': selectedCategory,
      'description': descriptionCtrl.text,
      'store': storeCtrl.text,
    }.toString());

    Navigator.pop(context);
  }
}
