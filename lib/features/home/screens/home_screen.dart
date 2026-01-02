import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:smartspend/features/expenses/widgets/weekly_chart.dart';
import '../../../cards/stat_card.dart';
import '../../../cards/wide_stat.dart';
import '../../../cards/quick_add_button.dart';
import '../../../cards/transaction_tile.dart';
import '../../../cards/section_card.dart';
import '../../expenses/screens/add_expense_screen.dart';
import '../../expenses/widgets/bottom_nav.dart';
import '../../../route/app_router.dart';
import '../../expenses/widgets/app_bar.dart';
import '../services/home_service.dart';
import '../../expenses/screens/edit_expense_screen.dart';
import '../../home/widget/add_button.dart';

// stateful widget
class HomeScreen extends StatefulWidget {
  
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

  double monthTotal = 0;
int transactionCount = 0;
double dailyAverage = 0;

List<Map<String, dynamic>> recentExpenses = [];
Map<DateTime, double> weeklyData = {};

bool isLoading = true;
@override
void initState() {
  super.initState();
  fetchHomeData();
}

void _showExpenseActions(Map<String, dynamic> e) {
  showModalBottomSheet(
    context: context,
    builder: (_) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Edit'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EditExpenseScreen(expense: e),
              ),
            ).then((_) => fetchHomeData());
            
            // open edit expense screen
          },
        ),
        ListTile(
          leading: const Icon(Icons.delete, color: Colors.red),
          title: const Text(''),
          onTap: () async {
            Navigator.pop(context);
            await deleteExpense(e['id']);
            fetchHomeData();
          },
        ),
      ],
    ),
  );
}




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
        child: AddExpenseScreen(),
      ),
    ),
  ).then((_) => fetchHomeData());
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: const SmartSpendHeader(subtitle: "Home"),
      bottomNavigationBar:AppBottomNav(
        currentIndex: 0,
        onTap: (index) => handleNav(context, index),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              const SizedBox(height: 20),

              /// Stats
              Row(
                children:  [
                  Expanded(child:StatCard(
                          title: 'This Month',
                          value: monthTotal,
                          subtitle: 'Total spent',
                          icon: Icons.attach_money,
                          iconBg: const Color(0xFFDDEBFF),
                        ),
                        ),
                                          SizedBox(width: 12),
                                          Expanded(child: StatCard(
                          title: 'Transactions',
                          value: transactionCount.toDouble(),
                          subtitle: 'Total recorded',
                          icon: Icons.calendar_today,
                          iconBg: const Color(0xFFF3E8FF),
                        ),
                        ),
                                        ],
                                      ),
                        
                                      const SizedBox(height: 12),
                        
                                      WideStatCard(
                          title: 'Daily Average',
                          value: dailyAverage.toStringAsFixed(2),
                        ),


              const SizedBox(height: 20),

              /// Quick Add
              const Text('Quick Add',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Row(
  children: [
    
    QuickAddButton(
      '+ Coffee',
      onTap: () => openAddExpense(context),
    ),
    const SizedBox(width: 10),
    QuickAddButton(
      '+ Groceries',
      onTap: () => openAddExpense(context),
    ),
    const SizedBox(width: 10),
    QuickAddButton(
      '+ Gas',
      onTap: () => openAddExpense(context),
    ),
  ],
),


              const SizedBox(height: 20),

              /// Chart
               SectionCard(
                title: '7-Day Trend',
                height: 180,
                child: Center(
                  child: WeeklyLineChart(dailyTotals: weeklyData),

                ),
              ),

              const SizedBox(height: 20),

              /// Recent
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Recent',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  TextButton.icon(
                    onPressed:exportExpensesToCSV,
                    icon: const Icon(Icons.download),
                    label: const Text('Export'),
                  )
                ],
              ),

              const SizedBox(height: 8),

Column(
  children: recentExpenses.map((e) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector( 
              onLongPress: () => _showExpenseActions(e),
              child: TransactionTile(
        title: e['description']?.toString().isNotEmpty == true
            ? e['description']
            : e['category'],
        subtitle:
            '${e['category']} · ${e['store'] ?? ''}',
        amount: '${e['amount']} birr',
        date: _formatDate(e['created_at']),
        emoji: _categoryEmoji(e['category']),
      ),),
    );
  }).toList(),
),

            ],
          ),
        ),
      ),
      floatingActionButton: AddButton(),
    );
  }
 
String _formatDate(String iso) {
  final date = DateTime.parse(iso);
  return '${date.month}/${date.day}';
}

String _categoryEmoji(String category) {
  const map = {
    'Food': '🍔',
    'Travel': '✈️',
    'Entertainment': '🎬',
    'Shopping': '🛒',
    'Health': '🩺',
    'Utility': '💧',
  };
  return map[category] ?? '💸';
}


 //backend logic to fetch data from supabase
 Future<void> fetchHomeData() async {
  weeklyData = await fetchWeeklySpending();

  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final client = Supabase.instance.client;

  final now = DateTime.now();
  final startOfMonth = DateTime(now.year, now.month, 1);

  try {
    // 1️⃣ Fetch this month's expenses
    final response = await client
        .from('expenses')
        .select()
        .eq('firebase_uid', user.uid)
        .gte('created_at', startOfMonth.toIso8601String())
        .order('created_at', ascending: false);

    final expenses = List<Map<String, dynamic>>.from(response);

    double total = 0;
    for (final e in expenses) {
      total += (e['amount'] as num).toDouble();
    }

    setState(() {
      monthTotal = total;
      transactionCount = expenses.length;
      dailyAverage =
          expenses.isEmpty ? 0 : total / DateTime.now().day;
      recentExpenses = expenses.take(5).toList();
      isLoading = false;
    });
  } catch (e) {
    debugPrint('Home fetch error: $e');
  }
}

  


}
