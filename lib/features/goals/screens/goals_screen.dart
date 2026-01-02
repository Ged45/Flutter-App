import 'package:flutter/material.dart';
import '../../expenses/widgets/app_bar.dart';
import'../../expenses/widgets/bottom_nav.dart';
import '../../../route/app_router.dart';
import'./new_goal_screen.dart';
import '../../home/widget/add_button.dart';
class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      /// Reusable header
      appBar: const SmartSpendHeader(subtitle: "Goal"),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 4,
        onTap: (index) => handleNav(context, index),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Top summary cards
            Row(
              children: const [
                Expanded(
                  child: _SummaryCard(
                    icon: Icons.track_changes,
                    label: "Goals",
                    bgColor: Color(0xFFEAF3FF),
                    iconColor: Color(0xFF2F80ED),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _SummaryCard(
                    icon: Icons.attach_money,
                    label: "Saved",
                    bgColor: Color(0xFFE9F9EE),
                    iconColor: Color(0xFF27AE60),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _SummaryCard(
                    icon: Icons.trending_up,
                    label: "Progress",
                    bgColor: Color(0xFFF1E8FF),
                    iconColor: Color(0xFF8F5CFF),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// Goal cards
            const _GoalCard(
              daysLeft: "160 days",
              progress: 0.42,
              savedText: "1250/3000 ETB",
              remainingText: "1750 to go",
            ),

            const SizedBox(height: 16),

            const _GoalCard(
              daysLeft: "373 days",
              progress: 0.45,
              savedText: "4500/10000 ETB",
              remainingText: "5550 to go",
            ),

            const SizedBox(height: 20),

            /// Create new goal
            Container(
              
              child:AddNewGoalButton(
  onTap: () {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const AddGoalBottomSheet(),
    );
  },
),

            ),
          ],
        ),
      ),

      /// Floating action button
      floatingActionButton: AddButton(),

      
    );
  }
}

/// ----------------------------
/// Summary Card
/// ----------------------------
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

/// ----------------------------
/// Goal Card
/// ----------------------------
class _GoalCard extends StatelessWidget {
  final String daysLeft;
  final double progress;
  final String savedText;
  final String remainingText;

  const _GoalCard({
    required this.daysLeft,
    required this.progress,
    required this.savedText,
    required this.remainingText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header row
          Row(
            children: [
              const Icon(Icons.calendar_today,
                  size: 16, color: Colors.grey),
              const SizedBox(width: 6),
              Text(daysLeft, style: const TextStyle(color: Colors.grey)),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF2F80ED),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "+ Add",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Amount
          Text(
            savedText,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          /// Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey.shade300,
              valueColor:
                  const AlwaysStoppedAnimation(Color(0xFF6A5AE0)),
            ),
          ),

          const SizedBox(height: 8),

          /// Footer
          Row(
            children: [
              Text(
                remainingText,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              Text(
                "${(progress * 100).toInt()}%",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
