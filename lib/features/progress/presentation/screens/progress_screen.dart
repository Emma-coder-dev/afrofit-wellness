import 'package:flutter/material.dart';
import '../../../../core/theme/color_palette.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/services/local_storage_service.dart';
import '../widgets/weight_chart.dart';
import 'add_weight_screen.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  Map<String, dynamic>? userData;
  List<Map<String, dynamic>> weightEntries = [];
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
      
      if (user != null) {
        final progressKey = 'progress_${user['id']}';
        final progressData = await LocalStorageService.getDailyLog(progressKey);
        
        setState(() {
          userData = user;
          weightEntries = progressData != null 
              ? List<Map<String, dynamic>>.from(progressData['entries'] ?? [])
              : [];
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading data: $e')),
        );
      }
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

    final currentWeight = userData!['currentWeight'] as double;
    final targetWeight = userData!['targetWeight'] as double;
    final initialWeight = weightEntries.isNotEmpty 
        ? weightEntries.first['weight'] as double 
        : currentWeight;
    final weightLost = initialWeight - currentWeight;
    final weightToGo = currentWeight - targetWeight;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Progress',
        showBackButton: true,
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stats Cards
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.trending_down,
                      label: 'Weight Lost',
                      value: '${weightLost.toStringAsFixed(1)} kg',
                      color: ColorPalette.success,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.flag,
                      label: 'To Goal',
                      value: '${weightToGo.toStringAsFixed(1)} kg',
                      color: ColorPalette.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.monitor_weight,
                      label: 'Current',
                      value: '${currentWeight.toStringAsFixed(1)} kg',
                      color: ColorPalette.secondary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.timeline,
                      label: 'Entries',
                      value: '${weightEntries.length}',
                      color: ColorPalette.accent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Weight Chart
              Text(
                'Weight Trend',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              WeightChart(
                weightData: weightEntries,
                targetWeight: targetWeight,
              ),
              const SizedBox(height: 24),

              // Recent Entries
              if (weightEntries.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Entries',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Show all entries
                      },
                      child: const Text('View All'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...weightEntries.reversed.take(5).map((entry) {
                  final date = DateTime.parse(entry['date'] as String);
                  final weight = entry['weight'] as double;
                  final notes = entry['notes'] as String?;

                  return _WeightEntryCard(
                    date: date,
                    weight: weight,
                    notes: notes,
                  );
                }),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddWeightScreen(),
            ),
          );

          if (result == true) {
            _loadData();
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Log Weight'),
        backgroundColor: ColorPalette.primary,
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: ColorPalette.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _WeightEntryCard extends StatelessWidget {
  final DateTime date;
  final double weight;
  final String? notes;

  const _WeightEntryCard({
    required this.date,
    required this.weight,
    this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorPalette.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.monitor_weight,
              color: ColorPalette.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${weight.toStringAsFixed(1)} kg',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${date.day}/${date.month}/${date.year}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: ColorPalette.textSecondary,
                  ),
                ),
                if (notes != null && notes!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    notes!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}