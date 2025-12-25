import 'package:flutter/material.dart';
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
 