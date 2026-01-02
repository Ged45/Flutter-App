import'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

Future<void> exportExpensesToCSV() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final client = Supabase.instance.client;

  final response = await client
      .from('expenses')
      .select()
      .eq('firebase_uid', user.uid)
      .order('created_at', ascending: false);

  final data = List<Map<String, dynamic>>.from(response);

  final rows = [
    ['Date', 'Amount', 'Category', 'Description', 'Store'],
    ...data.map((e) => [
          e['created_at'],
          e['amount'],
          e['category'],
          e['description'] ?? '',
          e['store'] ?? '',
        ]),
  ];

  final csv = const ListToCsvConverter().convert(rows);

  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/expenses.csv');

  await file.writeAsString(csv);

  debugPrint('CSV exported to ${file.path}');
}


Future<Map<DateTime, double>> fetchWeeklySpending() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return {};

  final client = Supabase.instance.client;
  final now = DateTime.now();
  final start = now.subtract(const Duration(days: 6));

  final response = await client
      .from('expenses')
      .select('amount, created_at')
      .eq('firebase_uid', user.uid)
      .gte('created_at', start.toIso8601String());

  final data = List<Map<String, dynamic>>.from(response);

  final Map<DateTime, double> result = {};

  for (final e in data) {
    final date = DateTime.parse(e['created_at']);
    final key = DateTime(date.year, date.month, date.day);

    result[key] =
        (result[key] ?? 0) + (e['amount'] as num).toDouble();
  }

  return result;
}



Future<void> deleteExpense(String id) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  await Supabase.instance.client
      .from('expenses')
      .delete()
      .eq('id', id)
      .eq('firebase_uid', user.uid);
}

Future<void> updateExpense({
  required String id,
  required double amount,
  required String category,
  required String description,
  String? store,
}) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  await Supabase.instance.client
      .from('expenses')
      .update({
        'amount': amount,
        'category': category,
        'description': description,
        'store': store,
      })
      .eq('id', id)
      .eq('firebase_uid', user.uid);
}
