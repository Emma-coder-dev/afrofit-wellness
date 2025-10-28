import 'package:flutter/material.dart';
import '../../../../core/theme/color_palette.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../shared/widgets/custom_app_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  bool dailyReminders = true;
  bool workoutReminders = true;
  bool waterReminders = true;
  String selectedUnit = 'metric';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Settings',
        showBackButton: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Notifications Section
          _SectionHeader(title: 'Notifications'),
          _SettingsTile(
            icon: Icons.notifications,
            title: 'Push Notifications',
            subtitle: 'Receive app notifications',
            trailing: Switch(
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() => notificationsEnabled = value);
              },
              activeColor: ColorPalette.primary,
            ),
          ),
          _SettingsTile(
            icon: Icons.alarm,
            title: 'Daily Reminders',
            subtitle: 'Remind me to log meals and workouts',
            trailing: Switch(
              value: dailyReminders,
              onChanged: notificationsEnabled
                  ? (value) {
                      setState(() => dailyReminders = value);
                    }
                  : null,
              activeColor: ColorPalette.primary,
            ),
          ),
          _SettingsTile(
            icon: Icons.fitness_center,
            title: 'Workout Reminders',
            subtitle: 'Remind me to exercise',
            trailing: Switch(
              value: workoutReminders,
              onChanged: notificationsEnabled
                  ? (value) {
                      setState(() => workoutReminders = value);
                    }
                  : null,
              activeColor: ColorPalette.primary,
            ),
          ),
          _SettingsTile(
            icon: Icons.water_drop,
            title: 'Water Reminders',
            subtitle: 'Remind me to stay hydrated',
            trailing: Switch(
              value: waterReminders,
              onChanged: notificationsEnabled
                  ? (value) {
                      setState(() => waterReminders = value);
                    }
                  : null,
              activeColor: ColorPalette.primary,
            ),
          ),
          const SizedBox(height: 24),

          // Units Section
          _SectionHeader(title: 'Units'),
          _SettingsTile(
            icon: Icons.straighten,
            title: 'Measurement System',
            subtitle: selectedUnit == 'metric' ? 'Metric (kg, cm)' : 'Imperial (lbs, inches)',
            trailing: DropdownButton<String>(
              value: selectedUnit,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(value: 'metric', child: Text('Metric')),
                DropdownMenuItem(value: 'imperial', child: Text('Imperial')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedUnit = value);
                }
              },
            ),
          ),
          const SizedBox(height: 24),

          // About Section
          _SectionHeader(title: 'About'),
          _SettingsTile(
            icon: Icons.info_outline,
            title: 'App Version',
            subtitle: '1.0.0',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.description,
            title: 'Privacy Policy',
            onTap: () {
              _showInfoDialog(
                context,
                'Privacy Policy',
                'Your data is stored locally on your device and is never shared with third parties.',
              );
            },
          ),
          _SettingsTile(
            icon: Icons.gavel,
            title: 'Terms of Service',
            onTap: () {
              _showInfoDialog(
                context,
                'Terms of Service',
                'By using AfroFit Wellness, you agree to use the app responsibly for fitness and health tracking purposes.',
              );
            },
          ),
          _SettingsTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {
              _showInfoDialog(
                context,
                'Help & Support',
                'Need help? Check our FAQ section or contact us at support@afrofitwellness.com',
              );
            },
          ),
        ],
      ),
    );
  }

  void _showInfoDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorPalette.primary,
            ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ColorPalette.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: ColorPalette.primary, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: const TextStyle(
                  fontSize: 13,
                  color: ColorPalette.textSecondary,
                ),
              )
            : null,
        trailing: trailing ??
            (onTap != null
                ? const Icon(Icons.arrow_forward_ios, size: 16)
                : null),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}