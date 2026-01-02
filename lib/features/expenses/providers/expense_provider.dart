import 'package:flutter/material.dart';
import '../../expenses/screens/add_expense_screen.dart';  




void openAddExpense(BuildContext context, {String? preset}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => DraggableScrollableSheet(
      initialChildSize: 0.92,
      minChildSize: 0.6,
      maxChildSize: 0.95,
      builder: (_, controller) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: AddExpenseScreen(presetProduct: {},),
      ),
    ),
  );
}

