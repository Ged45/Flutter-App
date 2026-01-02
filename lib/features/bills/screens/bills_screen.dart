import 'package:flutter/material.dart';
import '../../expenses/widgets/bottom_nav.dart';
import '../../../route/app_router.dart';
import '../../expenses/widgets/app_bar.dart';
import '../../home/widget/add_button.dart';
class BillsScreen extends StatefulWidget {
  const BillsScreen({super.key});

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: const SmartSpendHeader(subtitle: "Bill"),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 3,
        onTap: (index) => handleNav(context, index),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Top Summary Cards
            Row(
              children: const [
                Expanded(
                  child: _SummaryCard(
                    icon: Icons.trending_up,
                    label: "Total Bills",
                    bgColor: Color(0xFFEAF3FF),
                    iconColor: Color(0xFF4A7CFF),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _SummaryCard(
                    icon: Icons.calendar_today,
                    label: "This week",
                    bgColor: Color(0xFFFFF6D8),
                    iconColor: Color(0xFFFFB703),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _SummaryCard(
                    icon: Icons.autorenew,
                    label: "Recurring",
                    bgColor: Color(0xFFF1E8FF),
                    iconColor: Color(0xFF8F5CFF),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// Notification Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFF4A7CFF), Color(0xFF7A4DFF)],
                ),
              ),
              child: Row(
                children: const [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.notifications_none, color: Colors.white),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Notifications On",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "3 days before due",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Bills List Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: const [
                  _BillItem(
                    date: "Dec 5",
                    category: "Housing",
                  ),
                  SizedBox(height: 12),
                  _BillItem(
                    date: "Dec 10",
                    category: "Utilities",
                  ),
                  SizedBox(height: 12),
                  _BillItem(
                    date: "Dec 15",
                    category: "Utilities",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Add New Bill Reminder
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
              ),
              child: const Center(
                child: Text(
                  "+ Add New Bill Reminder",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: AddButton(),
      
    );
  }
}

/// --------------------
/// Reusable Widgets
/// --------------------

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bgColor;
  final Color iconColor;

  const _SummaryCard({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _BillItem extends StatelessWidget {
  final String date;
  final String category;

  const _BillItem({
    required this.date,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF1E8FF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Auto",
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF8F5CFF),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
          const SizedBox(width: 4),
          Text(date, style: const TextStyle(color: Colors.grey)),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(category, style: const TextStyle(fontSize: 12)),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Overdue",
              style: TextStyle(
                fontSize: 12,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
