import 'package:flutter/material.dart';
import '../../../../core/theme/color_palette.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/services/local_storage_service.dart';
import 'edit_profile_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);

    try {
      final user = await LocalStorageService.getUserData();
      setState(() {
        userData = user;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading data: $e')),
        );
      }
    }
  }

  String _getBodyShapeName(String shapeId) {
    switch (shapeId) {
      case 'hourglass':
        return 'Hourglass';
      case 'athletic':
        return 'Athletic/Toned';
      case 'slim':
        return 'Slim/Slender';
      case 'curvy':
        return 'Curvy/Thick';
      case 'pear':
        return 'Pear Shape';
      case 'apple':
        return 'Apple Shape';
      default:
        return 'Custom';
    }
  }

  String _getActivityLevelName(String level) {
    switch (level) {
      case 'sedentary':
        return 'Sedentary';
      case 'lightly_active':
        return 'Lightly Active';
      case 'moderately_active':
        return 'Moderately Active';
      case 'very_active':
        return 'Very Active';
      default:
        return level;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (userData == null) {
      return const Scaffold(
        body: Center(
          child: Text('No user data found'),
        ),
      );
    }

    final name = userData!['name'] as String;
    final age = userData!['age'] as int;
    final gender = userData!['gender'] as String;
    final currentWeight = userData!['currentWeight'] as double;
    final targetWeight = userData!['targetWeight'] as double;
    final height = userData!['height'] as double;
    final activityLevel = userData!['activityLevel'] as String;
    final bodyShape = userData!['desiredBodyShape'] as String;
    final bmi = currentWeight / ((height / 100) * (height / 100));

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
              if (result == true) {
                _loadData();
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorPalette.primary.withValues(alpha: 0.1),
                    ColorPalette.secondary.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ColorPalette.primary.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: ColorPalette.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$age years old • ${gender[0].toUpperCase()}${gender.substring(1)}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorPalette.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileScreen(),
                        ),
                      );
                      if (result == true) {
                        _loadData();
                      }
                    },
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Edit Profile'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Body Stats
            _SectionTitle(title: 'Body Stats'),
            const SizedBox(height: 12),
            _InfoCard(
              children: [
                _InfoRow(
                  icon: Icons.monitor_weight,
                  label: 'Current Weight',
                  value: '${currentWeight.toStringAsFixed(1)} kg',
                ),
                const Divider(height: 24),
                _InfoRow(
                  icon: Icons.flag,
                  label: 'Target Weight',
                  value: '${targetWeight.toStringAsFixed(1)} kg',
                ),
                const Divider(height: 24),
                _InfoRow(
                  icon: Icons.straighten,
                  label: 'Height',
                  value: '${height.toStringAsFixed(0)} cm',
                ),
                const Divider(height: 24),
                _InfoRow(
                  icon: Icons.assessment,
                  label: 'BMI',
                  value: bmi.toStringAsFixed(1),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Fitness Goals
            _SectionTitle(title: 'Fitness Goals'),
            const SizedBox(height: 12),
            _InfoCard(
              children: [
                _InfoRow(
                  icon: Icons.emoji_events,
                  label: 'Body Goal',
                  value: _getBodyShapeName(bodyShape),
                ),
                const Divider(height: 24),
                _InfoRow(
                  icon: Icons.directions_run,
                  label: 'Activity Level',
                  value: _getActivityLevelName(activityLevel),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Daily Goals
            _SectionTitle(title: 'Daily Targets'),
            const SizedBox(height: 12),
            _InfoCard(
              children: [
                _InfoRow(
                  icon: Icons.local_fire_department,
                  label: 'Calories',
                  value: '${userData!['dailyGoals']['calories']} kcal',
                ),
                const Divider(height: 24),
                _InfoRow(
                  icon: Icons.fitness_center,
                  label: 'Protein',
                  value: '${userData!['dailyGoals']['protein']}g',
                ),
                const Divider(height: 24),
                _InfoRow(
                  icon: Icons.water_drop,
                  label: 'Water',
                  value: '${userData!['dailyGoals']['water']}ml',
                ),
              ],
            ),
            const SizedBox(height: 24),

            // App Info
            _SectionTitle(title: 'About'),
            const SizedBox(height: 12),
            _InfoCard(
              children: [
                _InfoRow(
                  icon: Icons.app_settings_alt,
                  label: 'App Version',
                  value: '1.0.0',
                ),
                const Divider(height: 24),
                _InfoRow(
                  icon: Icons.calendar_today,
                  label: 'Member Since',
                  value: _formatDate(userData!['createdAt'] as String),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showResetDialog(),
                icon: const Icon(Icons.refresh),
                label: const Text('Reset App Data'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: ColorPalette.error,
                  side: const BorderSide(color: ColorPalette.error),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateStr) {
    final date = DateTime.parse(dateStr);
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.year}';
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset App Data?'),
        content: const Text(
          'This will delete all your data including meals, workouts, and progress. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await LocalStorageService.clearAllData();
              if (context.mounted) {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            },
            style: TextButton.styleFrom(foregroundColor: ColorPalette.error),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;

  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorPalette.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: ColorPalette.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: ColorPalette.textSecondary,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}