import 'package:flutter/material.dart';
import '../../expenses/widgets/app_bar.dart';
import '../../expenses/widgets/bottom_nav.dart';
import '../../../route/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      /// Header
     appBar: const SmartSpendHeader(subtitle: "Insigts"), 
      bottomNavigationBar: AppBottomNav(
        currentIndex: 0,
        onTap: (index) => handleNav(context, index),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Profile Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [Color(0xFF4A7CFF), Color(0xFF7A4DFF)],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white24,
                        child: Icon(Icons.person_outline,
                            size: 32, color: Colors.white),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Gedion",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "gedions884@gmail.com",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.edit, color: Colors.white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Divider(color: Colors.white24),

                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _ProfileInfo(
                        label: "Member Since",
                        value: "6 days ago",
                      ),
                      _ProfileInfo(
                        label: "Account Status",
                        value: "● Active",
                        valueColor: Colors.lightGreenAccent,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            /// Notifications
            const _SectionTitle("Notifications"),
            const SizedBox(height: 12),
            const SettingSwitchTile(
              icon: Icons.notifications_none,
              title: "Receive all notifications",
            ),
            const SizedBox(height: 12),
            const SettingSwitchTile(
              icon: Icons.calendar_today,
              title: "Get notified about upcoming bills",
              iconColor: Color(0xFFB76CFF),
            ),

            const SizedBox(height: 24),

            /// Preferences
            const _SectionTitle("Preferences"),
            const SizedBox(height: 12),
            const SettingSwitchTile(
              icon: Icons.dark_mode_outlined,
              title: "Enable dark theme",
            ),
            const SizedBox(height: 12),
            const SettingNavigationTile(
              icon: Icons.translate,
              title: "English",
            ),
            const SizedBox(height: 12),
            const SettingNavigationTile(
              icon: Icons.attach_money,
              title: "ETB - tap to change",
              iconColor: Colors.green,
            ),
            const SizedBox(height: 12),
            const SettingNavigationTile(
              icon: Icons.calendar_month,
              title: "MM/DD/YYYY",
            ),

            const SizedBox(height: 24),

            /// Privacy & Security
            const _SectionTitle("Privacy and Security"),
            const SizedBox(height: 12),
            const SettingSwitchTile(
              icon: Icons.lock_outline,
              title: "Use fingerprint / face unlock",
            ),
            const SizedBox(height: 12),
            const SettingNavigationTile(
              icon: Icons.security,
              title: "Update your password",
            ),
            const SizedBox(height: 12),
            const SettingNavigationTile(
              icon: Icons.remove_red_eye_outlined,
              title: "Control your data",
            ),

            const SizedBox(height: 24),

            /// Data Management
            const _SectionTitle("Data Management"),
            const SizedBox(height: 12),
            const SettingNavigationTile(
              icon: Icons.download,
              title: "Download your expenses as PDF",
            ),
            const SizedBox(height: 12),
            const SettingNavigationTile(
              icon: Icons.backup_outlined,
              title: "Manage data backups",
            ),

            const SizedBox(height: 30),

            /// Log out
            Center(
              child: GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "Log Out",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
class _ProfileInfo extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _ProfileInfo({
    required this.label,
    required this.value,
    this.valueColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
class SettingSwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;

  const SettingSwitchTile({
    super.key,
    required this.icon,
    required this.title,
    this.iconColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.lightBlue.shade100,
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 14),
          Expanded(child: Text(title)),
          Switch(value: false, onChanged: (_) {}),
        ],
      ),
    );
  }
}
class SettingNavigationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;

  const SettingNavigationTile({
    super.key,
    required this.icon,
    required this.title,
    this.iconColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.lightBlue.shade100,
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 14),
          Expanded(child: Text(title)),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
