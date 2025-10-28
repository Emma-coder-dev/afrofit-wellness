import 'package:flutter/material.dart';
import '../../../../core/theme/color_palette.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/services/local_storage_service.dart';

class AddWeightScreen extends StatefulWidget {
  const AddWeightScreen({super.key});

  @override
  State<AddWeightScreen> createState() => _AddWeightScreenState();
}

class _AddWeightScreenState extends State<AddWeightScreen> {
  final TextEditingController _weightController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String? notes;

  Future<void> _saveWeight() async {
    if (_weightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your weight')),
      );
      return;
    }

    try {
      final weight = double.parse(_weightController.text);
      
      if (weight <= 0 || weight > 500) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid weight')),
        );
        return;
      }

      // Get current progress data
      final userData = await LocalStorageService.getUserData();
      if (userData == null) return;

      // Get existing progress entries
      final progressKey = 'progress_${userData['id']}';
      var progressData = await LocalStorageService.getDailyLog(progressKey);
      
      if (progressData == null) {
        progressData = {'entries': []};
      }

      // Add new entry
      final entries = List<Map<String, dynamic>>.from(progressData['entries'] ?? []);
      entries.add({
        'date': selectedDate.toIso8601String(),
        'weight': weight,
        'notes': notes,
      });

      // Sort by date
      entries.sort((a, b) => DateTime.parse(a['date']).compareTo(DateTime.parse(b['date'])));

      progressData['entries'] = entries;

      // Save progress data
      await LocalStorageService.saveDailyLog(progressKey, progressData);

      // Update current weight in user data
      userData['currentWeight'] = weight;
      await LocalStorageService.saveUserData(userData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Weight logged successfully! 🎉'),
            backgroundColor: ColorPalette.success,
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Log Weight',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Weight Input
            Text(
              'Your Weight',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: 'Enter weight',
                suffixText: 'kg',
                prefixIcon: const Icon(Icons.monitor_weight),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Date Selector
            Text(
              'Date',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: _selectDate,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: ColorPalette.primary),
                    const SizedBox(width: 12),
                    Text(
                      '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Notes (Optional)
            Text(
              'Notes (Optional)',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            TextField(
              onChanged: (value) => notes = value,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'How are you feeling? Any changes?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
            ),
            const SizedBox(height: 32),

            // Save Button
            PrimaryButton(
              text: 'Save Weight',
              onPressed: _saveWeight,
              icon: Icons.check,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }
}