import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/bottom_nav.dart';
import '../../../route/app_router.dart';
class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4F7CFF),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: AppBottomNav(
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

              /// Top Stat Cards
              Row(
                children: const [
                  Expanded(
                    child: _InsightStat(
                      title: 'Top',
                      icon: Icons.attach_money,
                      iconBg: Color(0xFFDDEBFF),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _InsightStat(
                      title: 'Categories',
                      icon: Icons.calendar_today,
                      iconBg: Color(0xFFF3E8FF),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _InsightStat(
                      title: 'Average',
                      icon: Icons.trending_down,
                      iconBg: Color(0xFFE6F8EC),
                      iconColor: Colors.green,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Chart Card
              _sectionCard(
                child: SizedBox(
                  height: 200,
                  child: BarChart(_barChartData()),
                ),
              ),

              const SizedBox(height: 20),

              /// Breakdown
              _breakdownCard(),
            ],
          ),
        ),
      ),
    );
  }

  // ───────────────────────── Header ─────────────────────────

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
              backgroundColor: Color(0xFF4F7CFF),
              child: Icon(Icons.attach_money, color: Colors.white),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Smart Spend',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Insights', style: TextStyle(color: Colors.black54)),
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

  // ───────────────────────── Breakdown Card ─────────────────────────

  Widget _breakdownCard() => _sectionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Breakdown',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download),
                  label: const Text('Export'),
                )
              ],
            ),
            const SizedBox(height: 12),

            _breakdownRow('Food', 0.38, Colors.blue, '4'),
            _breakdownRow('Health', 0.22, Colors.purple, '1'),
            _breakdownRow('Travel', 0.18, Colors.pink, '1'),
            _breakdownRow('Shopping', 0.12, Colors.orange, '1'),
            _breakdownRow('Entertainment', 0.10, Colors.green, '1'),
          ],
        ),
      );

  Widget _breakdownRow(
      String title, double value, Color color, String count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration:
                    BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
              ),
              const SizedBox(width: 8),
              Text('$title ($count)'),
              const Spacer(),
              Text('${(value * 100).toInt()}%'),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 8,
              backgroundColor: Colors.grey.shade300,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────── Reusable Card ─────────────────────────

  Widget _sectionCard({required Widget child}) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: child,
      );

  // ───────────────────────── Chart Data ─────────────────────────

  BarChartData _barChartData() => BarChartData(
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                const labels = [
                  'Food',
                  'Health',
                  'Travel',
                  'Shopping',
                  'Entertainment'
                ];
                return Text(labels[value.toInt()],
                    style: const TextStyle(fontSize: 10));
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        barGroups: [
          _bar(0, 200),
          _bar(1, 150),
          _bar(2, 90),
          _bar(3, 65),
          _bar(4, 35),
        ],
      );

  BarChartGroupData _bar(int x, double y) => BarChartGroupData(
        x: x,
        barRods: [
          BarChartRodData(
            toY: y,
            color: const Color(0xFF4F7CFF),
            width: 22,
            borderRadius: BorderRadius.circular(6),
          ),
        ],
      );

  // ───────────────────────── Bottom Nav ─────────────────────────


}

/// ───────────────────────── Insight Stat Card ─────────────────────────

class _InsightStat extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;

  const _InsightStat({
    required this.title,
    required this.icon,
    required this.iconBg,
    this.iconColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: iconBg,
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}
