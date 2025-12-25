import 'package:flutter/material.dart';
import 'package:smartspend/features/expenses/widgets/weekly_chart.dart';
import '../../../cards/stat_card.dart';
import '../../../cards/wide_stat.dart';
import '../../../cards/quick_add_button.dart';
import '../../../cards/transaction_tile.dart';
import '../../../cards/section_card.dart';
import '../../expenses/screens/add_expense_screen.dart';
import '../../expenses/widgets/bottom_nav.dart';
import '../../../route/app_router.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
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
              _header(),
              const SizedBox(height: 20),

              /// Stats
              Row(
                children: const [
                  Expanded(child: StatCard(
                    title: 'This Month',
                    value: '1775.50 Birr',
                    subtitle: '↗ 29.2%',
                    icon: Icons.attach_money,
                    iconBg: Color(0xFFDDEBFF),
                  )),
                  SizedBox(width: 12),
                  Expanded(child: StatCard(
                    title: 'Transactions',
                    value: '8',
                    subtitle: 'Total recorded',
                    icon: Icons.calendar_today,
                    iconBg: Color(0xFFF3E8FF),
                  )),
                ],
              ),

              const SizedBox(height: 12),

              const WideStatCard(
                title: 'Daily Average',
                value: '177.5 Birr',
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
              const SectionCard(
                title: '7-Day Trend',
                height: 180,
                child: Center(
                  child: WeeklyLineChart(),
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
                    onPressed: () {},
                    icon: const Icon(Icons.download),
                    label: const Text('Export'),
                  )
                ],
              ),

              const SizedBox(height: 8),

              const TransactionTile(
                title: 'Grocery Shopping',
                subtitle: 'Food · Whole Foods',
                amount: '455 birr',
                date: 'Dec 3',
                emoji: '🍔',
              ),
              const SizedBox(height: 8),
              const TransactionTile(
                title: 'Clothes',
                subtitle: 'Shopping',
                amount: '5550 birr',
                date: 'Dec 3',
                emoji: '👕',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFE9F2FF), Color(0xFFFCE7F3)],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 22,
              backgroundColor: Colors.blue,
              child: Icon(Icons.attach_money, color: Colors.white),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Smart Spend',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Home', style: TextStyle(color: Colors.black54)),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person_outline),
            )
          ],
        ),
      );


}
