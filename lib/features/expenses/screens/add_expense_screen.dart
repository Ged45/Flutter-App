import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/amount_field.dart';
import '../widgets/categoriy_grid.dart';
import '../widgets/label.dart';
import '../widgets/submit_button.dart';
import '../widgets/text_field.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key, required Map<String, dynamic> presetProduct});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  
  String selectedCategory = 'Food';

  final amountCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final storeCtrl = TextEditingController();

  bool loading = false;

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
                 amountField(
                  controller: amountCtrl),

                const SizedBox(height: 24),
                label('Category'),
                const SizedBox(height: 12),
              
CategoryGrid(
  categories: categories,
  selectedCategory: selectedCategory,
  onCategorySelected: (category) {
    setState(() {
      selectedCategory = category;
    });
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
            onPressed: loading
                ? null
                : () async {
                    setState(() => loading = true);
                    await submit();
                    setState(() => loading = false);
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: loading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    'Add Expense',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      );


  




  // ───────────────────────── Logic ─────────────────────────

   

Future<void> submit() async {
  final amount = double.tryParse(amountCtrl.text);

  if (amount == null || amount <= 0) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter a valid amount')),
    );
    return;
  }

  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User not authenticated')),
    );
    return;
  }

  try {
    await Supabase.instance.client.from('expenses').insert({
      'firebase_uid': user.uid,
      'amount': amount,
      'category': selectedCategory,
      'description': descriptionCtrl.text.trim(),
      'store': storeCtrl.text.trim(),
    });

    Navigator.pop(context);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to add expense: $e')),
    );
  }
}
  
}
