import'package:flutter/material.dart';
import '../../expenses/providers/expense_provider.dart';
//create widget for add button with gradient background and plus icon
class AddButton extends StatelessWidget {
  const AddButton({super.key});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
         child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF4A7BFF),
                      Color(0xFF7A3CF0),
                    ],
                  ),
                ),
                child: const Center(
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              onPressed: () {
          openAddExpense(context);
        },
  );
  }
}