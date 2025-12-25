import'package:flutter/material.dart';
import'./box_decoration.dart';


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
  Widget amountField() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: boxDecoration(),
        child: TextField(
          controller: amountCtrl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'ETB  0.00',
            hintStyle: TextStyle(color: Colors.black38),
            suffixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.keyboard_arrow_up, size: 18),
                Icon(Icons.keyboard_arrow_down, size: 18),
              ],
            ),
          ),
        ),
      );